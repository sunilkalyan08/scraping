# require 'mechanize'
# require 'pry'
# require 'csv'

# mechanize = Mechanize.new
# page = mechanize.get("http://www.lawsofindia.org/advanced.php")
# form = page.forms.last

# form['toyear'] = '2015'
# form['selectstate[]'] = "18"

# page = form.submit
# page.search('.btxt12 div li a').each do |row|
# 	page_new = mechanize.get(row["href"])
# 	binding.pry
# end
# binding.pry

require 'mechanize'
require 'pry'
require 'csv'
require 'uri'
require 'fileutils'

mechanize = Mechanize.new
page = mechanize.get("http://www.lawsofindia.org/advanced.php")
form = page.forms.last
form['toyear'] = '2015'
pages = form.submit

# page_urls = mechanize.get("http://www.lawsofindia.org/searchresult.php")
urls = []

pages.search('.btxt12 li a:not([class!=""])').each do |row|
	urls << row["href"]
end

urls.each do |pdf_link|

		vist_link = mechanize.get(pdf_link)
		
		download_link = vist_link.search('.post-info p a')
		link = download_link[0]["href"].split("file=")[1].split("&")[0]
		city = vist_link.search('.middleCon p strong').text().split("from").last.strip
		system("wget --referer=http://www.lawsofindia.org/statelaw/6159/TheManipurStateMinoritiesCommissionAct2010.html  http://www.lawsofindia.org/pdf/#{link} -P #{Dir.home}/laws_pdf")
		act = vist_link.search('.middleCon .post-info')[0].text.strip
		act_num = vist_link.search('.middleCon p[style*="text-align: center"]').text().split(":")[1].split("of")[0].strip
		year = vist_link.search('.middleCon p[style*="text-align: center"]').text().split(":")[1].split("of").last.strip
		keywords= vist_link.search('.middleCon p')[1].text().strip
		link_path = link.split("/").last
		path = "#{Dir.home}/laws_pdf/#{link_path}"
		CSV.open("#{Dir.home}/laws_of_india.csv", 'a+') do |exc|
			exc << ["#{act}", "#{act_num}", "#{year}","#{keywords}","#{city}", "#{path}"]
		end
end
















# mechanize.redirect_ok = true

# check_ids = []
# page.search('#stateform input[type=checkbox]').each do |chk|
# 	a = chk["id"].split("checkbox")
# 	check_ids << a[1]
# end
# check_ids.map!(&:to_i)
# form = page.forms.last

# form['selectstate[]'] = "30"

# page.search('.btxt12 div li a').each do |row|
# 	page_new = mechanize.get(row["href"])
# 	page_new.search('.year a').each do |link_year|
# 		post_req = mechanize.post('http://www.lawsofindia.org/getlaw.php' , {"state" => "30","year" => "#{link_year.text}"})
# 		binding.pry
# 		post_req.search('li a').each do |dow|
# 			post_req.search('li a[style*="text-decoration:none"]').each do |do1|
# 			if ((dow["href"].include? link_year.text) && (do1["href"].include? link_year.text))
# 				a = do1["href"].split("file=")[1].split("&")[0]
# 				b = "#{row["href"]}"+" "+"http://www.lawsofindia.org/pdf/#{a}"
# 				system("wget --referer=#{b}")
# 			end
# 			end
# 		end
# 	end

# end













# mechanize.request_headers
			# mechanize.robots = false
			# mechanize.pluggable_parser.default = Mechanize::Download
			# mechanize = Mechanize.new { |agent| agent.user_agent_alias = 'Windows IE 9'}
			# mechanize.get("http://www.lawsofindia.org#{dow["href"]}").save('/home/sunil/a')
			# wget --referer= "#{dow["href"]}"
				# c = "http://www.lawsofindia.org/pdf/#{a}"
				# system('wget --referer=http://www.lawsofindia.org/statelaw/6159/TheManipurStateMinoritiesCommissionAct2010.html  http://www.lawsofindia.org/pdf/manipur/1966/1966Manipur9.pdf')
				# system('wget --referer= "#{d}"')
				# exec("wget --referer= #{b}")
# wget --referer=http://www.lawsofindia.org/statelaw/6159/TheManipurStateMinoritiesCommissionAct2010.html  http://www.lawsofindia.org/pdf/manipur/1966/1966Manipur9.pdf


# wget --referer="http://www.lawsofindia.org/statelaw/6159/TheManipurStateMinoritiesCommissionAct2010.html http://www.lawsofindia.org/pdf/manipur/1966/1966Manipur9.pdf"



# PHPSESSID=692d7ddb936bf412a7237cf533c2a8ff;
# __utma=118196884.2104294772.1463573113.1463573113.1463635678.2;
# __utmb=118196884.5.10.1463635678;
# __utmc=118196884;
# __utmz=118196884.1463573113.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none);
# __atuvc=12%7C20; __atuvs=573d4ede67c1202f002





