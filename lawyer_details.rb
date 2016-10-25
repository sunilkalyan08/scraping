require 'capybara/poltergeist'
require 'pry'
require 'csv'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist
browser = Capybara.current_session
CSV.open("#{Dir.home}/lawyer_details.csv",'a+',:write_headers=> true,:headers => ["Address","Landmark","Contact Person", "Mobile", "Landline", "Fax", "Email", "Website"]) do |exc|
	CSV.foreach("#{Dir.home}/lawyers.csv") do |row|
		url = row[0]
		browser.visit url
		sleep(5)
		links = browser.find('.info')
		links1 = links.all('li')
		address,landmark,contact_person,mobile,landline,fax,email,website = nil
		links1.each do |res|
			binding.pry
			a = res.text.split(":")
			if(a[1].strip!= "Lawyers")
				if(a[0].strip == "Address")
					address =  a[1]
				elsif (a[0].strip == "Landmark")
					landmark =  a[1]
				elsif (a[0].strip == "Contact Person")
					contact_person = a[1]
				elsif (a[0].strip == "Mobile")
					mobile =  a[1]
				elsif (a[0].strip == "Landline")
					landline = a[1]
				elsif (a[0].strip == "Fax")
					fax =  a[1]
				elsif (a[0].strip == "Email")
					email =  a[1]
				elsif (a[0].strip == "Website")
					website =  a[1]
				end
			end
		end
		exc << ["#{address}", "#{landmark}", "#{contact_person}", "#{mobile}", "#{landline}", "#{fax}", "#{email}", "#{website}"]
	end
end