class NewsZipFiles

  attr_accessor :zip_file_extensions, :zip_files, :url

  def initialize(params={})
    @zip_file_paths = []
    @zip_file_extensions = []
    @url = params[:url] || "http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/"
  end

  def fetch
    doc = Nokogiri::HTML(HTTParty.get(self.url).body)
    table_row_links = doc.css("tr a")

    table_row_links.each do |row_link|
      if !!row_link.attributes["href"].value.match(/.zip\z/)
        self.zip_file_extensions << row_link.attributes["href"].value
      end
    end

  end

  def process_zip_files
    @zip_file_extensions.each do |extension|
      current_zip_file = NewsZipFile.new({zip_file_path: extension, base_url: self.url})
      current_zip_file.download_and_process
    end
  end

end