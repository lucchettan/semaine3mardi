require 'bundler'
Bundler.require


$:.unshift File.expand_path("./../lib/app/", __FILE__)
require 'scrapping.rb'

def save_json
	tempHash = Scrapper.new.get_townhall_email

	File.open("db/emails.json","w") do |f|
	f.write(tempHash.to_json)
	end
end

def save_as_csv
   tempHash = Scrapper.new.get_townhall_email
   CSV.open(“bd/emails.csv”, “wb”) do |csv|
   tempHash.to_a.each{|elem| csv << elem}
   end
end

def save_drive
#aller dans console.developers.google.com
#lancer une cle API
#lancer "session" dans le terminal repondre la cle repondu sur la page internet
	session = GoogleDrive::Session.from_config("config.com")

#ouvrir la spreadsheet avec la cle de reference de son url d/"eiorngoierbng"/edit.com
	ws = session.spreadsheet_by_key("1x2YRSQEpR_G7a5jGxhZMK_8zzSnwOKguRysHRUvyP_k").worksheets[0]
		i = 1
		Scrapper.new.get_townhall_email.each do |k,v| 
      	ws[i, 1] = k # pour chaque élément, je remplis la ligne associée avec la clé et la valeur
      	ws[i,2] = v
      	sleep(1.001) # je mets une seconde car la rate bloque à 100 requêtes pour 100 secondes
      	i += 1 # j'incrémente mon i de 1 pour passer à la ligne suivante
      	ws.save
    end
end
save_drive