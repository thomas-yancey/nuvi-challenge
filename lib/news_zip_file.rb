class NewsZipFile

  attr_accessor :zip_file_path
  attr_reader :base_url

  def initialize(params={})
    @zip_file_path = params[:zip_file_path]
    @base_url = params[:base_url]
  end

  def download_and_process
    self.download_zip_file
    self.unzip_and_publish_contents
  end

  def download_zip_file
    puts "downloading"
    zipfile = File.new("tmp/#{self.zip_file_path}", "w")
    zipfile.write(HTTParty.get(download_url(self.zip_file_path)).body)
    zipfile.close
    puts "completed"
    zipfile
  end

  def download_url(extension)
    self.base_url + extension
  end

  def unzip_and_publish_contents

    Zip::File.open("tmp/#{self.zip_file_path}") do |zip_file|
      zip_file.each do |xml_file|
        content = xml_file.get_input_stream.read
        news_article = NewsArticle.new({content: content, filename: xml_file.name})
        news_article.publish
      end
    end
  end

end
