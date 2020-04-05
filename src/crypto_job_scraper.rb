require 'nokogiri'
require 'httparty'
require 'byebug'
require 'csv'

class Job 
    attr_accessor :company, :title, :listing_url, :location, :category

    def initialize(company, title, listing_url, location, category)
        @company = company
        @title = title
        @listing_url = listing_url
        @location = location
        @category = category
       
    end
       
end

def crypto_job_scraper()
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
    job_info_list_in_rows = job_listings.css('ul')

    # populating array with every second element of jobs_info_list_in_rows
    job_info_list_in_rows_str_arr = []
    for i in 0..job_info_list_in_rows.length-1
        if i % 2 == 0
            job_info_list_in_rows_str_arr.push(job_info_list_in_rows[i].text)
        end
    end

    jobs = []
    # Populating an object?
    for i in 0..job_companies.length-1

        job_info_str_arr = job_info_list_in_rows_str_arr[i].split(/\W+/)
        
        # This is the syntax the example used - not sure what it means or why I can't get it to work this way
        # job = {
        #     company: job_companies[i].text,
        #     title: job_titles[i].text,
        #     listing_url: job_titles[i].attributes["href"].value,
        #     location: job_info_str_arr[1],
        #     category: job_info_str_arr[2]
        # }
        company = job_companies[i].text
        title = job_titles[i].text
        listing_url = job_titles[i].attributes["href"].value
        location = job_info_str_arr[1]
        category = job_info_str_arr[2]

        job = Job.new(company, title, listing_url, location, category)
        
        jobs.push(job)
    end

    return jobs
end



# Only passing in a Player object here - Ruby not staticly typed so mentioning it here
def save_to_csv(jobs)
    CSV.open('../docs/cryptocurrencyjobslist.csv', 'wb') do |csv|
        csv << ["Company", "Title", "Link", "Location", "Category"]
        for i in 0..jobs.length-1
            csv << [jobs[i].company, jobs[i].title, jobs[i].listing_url, jobs[i].location, jobs[i].category]
        end
    end
end


jobs = crypto_job_scraper()
save_to_csv(jobs)
