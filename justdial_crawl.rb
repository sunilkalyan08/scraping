require 'open-uri'
require 'nokogiri'
require 'csv'
require 'roo-xls'
require 'net/http'
require 'json'
require 'pry'
directory = "/home/prabhu/Desktop/april/204_2016/justdial/*"
Dir.glob(directory) do |item|
	spreadsheet = Roo::Excel.new(item)
	start = 2
	(start..spreadsheet.last_row).each do |i|
		k = spreadsheet.row(i)
		CSV.open("results_#{k[1]}.csv", 'a+') do |res|
			CSV.open("skipped_#{k[1]}.csv", 'a+') do |skp|
				puts "#{k[0]}"
				puts "#{k[1]}"
				source = "http://www.justdial.com/functions/ajxsearch.php?national_search=0&act=pagination&city=Kolkata&search=Lawyers+For+Divorce+Case&where=&catid="+"#{k[0]}"+"&psearch=&prid=&page=3&SID=&mntypgrp=0"
				puts "#{source}"
				resp = Net::HTTP.get_response(URI.parse(source))
				data = resp.body
				result = JSON.parse(data)
				page = result["lastPageNum"]
				puts "#{page}"
				page.times.each do |i|
					begin
						url = "#{k[1]}"+"#{i+1}"
						puts "the url is******"
						puts "#{url}"
						puts "*****************"
						doc = Nokogiri::HTML(open("#{url}"))
						doc.css(".jcn a").each do |link|
							lin = link.attribute("href").text
							res << ["#{lin}"]
							puts "#{lin}"
						end
					rescue 
						skip = "#{k[1]}"+"#{i+1}"
						skp << ["#{skip}"]
						puts "#{k[1]}"+"#{i+1}"
					end
				end
			end
		end
	end
end