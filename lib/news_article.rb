class NewsArticle

  attr_reader :content, :channel, :filename

  def initialize(params={})
    @content = params[:content]
    @channel = params[:channel] || "NEWS_XML"
    @filename = params[:filename]
  end

  def publish
    if self.not_yet_published?
      $redis.set(filename, content)
      $redis.publish(channel, $redis.get(filename))
    end
  end

  def not_yet_published?
    !$redis.exists(self.filename)
  end

end
