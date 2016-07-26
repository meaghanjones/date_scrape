require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

#this is how we request the page we are going to scrape
page = HTTParty.get('https://portland.craigslist.org/search/eve?sale_date=2016-07-26')

#this is where we transform out http response into a nokogiri object
parse_page = Nokogiri::HTML(page)

#this is an empty array where the all the craiglist events will be stores
events_array = []

#this is where we parse the data
parse_page.css('.content').css('.row').css('.txt').css('.pl').map do |a|
  post_name = a.text
  events_array.push(post_name)
end

#this will push the array into a CSV file
CSV.open('events.csv', 'w') do |csv|
  csv << events_array
end
