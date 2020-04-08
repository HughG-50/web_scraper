# Ruby Web Scrapers

Web scrapers that I made using the Ruby gems HTTParty and Nokogiri. These programs get the raw data from the websites, parse it and store it into a useful format of a CSV file in the docs folder - which can then easily be used at a later date.

## Crypto Jobs List Scraper 

The crypto_job_scraper.rb, scrapes the following Cryptocurrency job listings website [cryptocurrencyjobs.co](https://cryptocurrencyjobs.co/).
It scrapes the following data:
* Company
* Title
* Job listing URL
* Location
* Category

This data is then saved into the CSV file, cryptocurrencyjobslist.csv in the docs folder.

## College Football Stats - ESPN Scraper

This web scraper was inspired by my friend who is a massive sports fan who is also into stats analysis, wanting a way to have clean data taken from stats web pages such as the ESPN website. 

In this example, all of the data in the table for the [2019 College QB stats](https://www.espn.com/college-football/stats/player/_/view/offense/table/passing/sort/passingYards/dir/desc) was scraped into a convenient CSV format, collegeQBstats.csv, which can then be processed at a later date.

## Installation and use

Clone/fork repository

```
bundle install
```

Then run the relevant ruby file
