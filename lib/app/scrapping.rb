require 'pry'
require 'nokogiri'
require 'open-uri'

#get_townhall_urls = annuaire.xpath('//*[@class="lientxt"]').collect(&:text)
#urltown = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/ableiges.html"))
class Scrapper

#sort le lien de chaque page de mairie
	@@page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	@@arr_mails = []

	def get_name
		@name = @@page.xpath('//a[@class="lientxt"]').collect{|ville| ville.text.downcase.gsub(" ", "_") }
	#Sort le nom des villes en downcase avec un "_"
	end

	def get_townhall_email
		@endlink = @@page.xpath('//a[@class="lientxt"]').collect{|x| x['href']}.each{|x| x.slice!(0)}
	#Sort la fin du lien de chaque ville en "/95/wy-dit-joli-village.html"
		@link_city = @endlink.map{|p| "http://annuaire-des-mairies.com" + p}
	#Sort chaque lien de ville
		result_mail = @link_city.each{|link| @@arr_mails.push(Nokogiri::HTML(open(link)).css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text)}
		@hash =Hash[get_name.zip(@@arr_mails)]
	end
end


