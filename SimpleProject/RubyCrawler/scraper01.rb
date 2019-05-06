require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    # url = "http://friendlibrary.ga"
    url = "https://www.italist.com"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    byebug
end

scraper
=begin
https://www.youtube.com/watch?v=b3CLEUBdWwQ
ruby scrapper.rb
unparsed_page
parsed_page
=end