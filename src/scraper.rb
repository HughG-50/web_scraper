require 'nokogiri'
require 'httparty'
require 'byebug'



def scraper()
    # URL that we want to target for our webscraper

    # Simple jobs list
    url = "https://cryptocurrencyjobs.co/"

    # Makes 'get' request to the page at the URL and returns the raw html of that page
    response = HTTParty.get(url)
    # parsed the data into a format that we can use to get data from
    # we are parsing the response body, and not the response itself
    # job_listings = []
    parsed_response = Nokogiri::HTML(response.body)
    job_listings = parsed_response.css('article div.dtc.v-top')
    
    # creating arrays of the different fields we want
    job_companies = job_listings.css('p a')
    job_titles = job_listings.css('h1 a')
    # job_info_row_list = job_listings.css('ul.list.f7.f6-ns.fw4.pb0.pb1-ns.pl0.pt1.blackest.lh-copy li.dib a.link.dim.blacktest')
    
    for i in 0..job_listings.length-1
        job = {
            # could also scrape the company URL - should add this in
            company: job_companies[i].text,
            title: job_titles[i].text
            # location: job_info_row_list[0].text,
            # category: job_info_row_list[1].text
        }
        
        byebug
    end
    
end

scraper()