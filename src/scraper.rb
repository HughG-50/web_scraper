require 'nokogiri'
require 'httparty'
require 'byebug'



def scraper()
    # URL that we want to target for our webscraper

    # Simple jobs list
    url = "https://cryptojobslist.com/"

    # Makes 'get' request to the page at the URL and returns the raw html of that page
    response = HTTParty.get(url)
    # parsed the data into a format that we can use to get data from
    # we are parsing the response body, and not the response itself
    parsed_response = Nokogiri::HTML(response.body)

    byebug
end

scraper()