require 'nokogiri'
require 'httparty'
require 'zip'
require 'redis'

require_relative 'news_zip_files'
require_relative 'news_zip_file'
require_relative 'news_article'

Dir.mkdir("tmp") unless Dir.exists?("tmp")

$redis = Redis.new
news_zip_files = NewsZipFiles.new
news_zip_files.fetch
news_zip_files.process_zip_files

# optional, delete all files after the program has run

Dir.foreach("./tmp") do |f|
  File.delete("#{Dir.pwd}/tmp/#{f}") unless f != '.' && f != '..'
end
