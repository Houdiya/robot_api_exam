#!/usr/bin/ruby
# nethttp.rb
require 'json'
require 'csv'
require 'json-csv'
require 'uri'
require 'net/http'
class RobotApiClient
    def ReponseGet(formatDonnees)
        begin

        uri = URI('http://localhost:3000/programing_languages')
        res = Net::HTTP.get_response(uri)
        resultat=res.body
        if ARGV[0].upcase=="json".upcase or formatDonnees.upcase=="json".upcase
            obj = JSON.parse(res.body)
            pretty_str = JSON.pretty_unparse(obj)
            response = [pretty_str]
            puts response 
        elsif ARGV[0].upcase=="csv".upcase or formatDonnees.upcase=="csv".upcase
            i="true"
            csv_string = CSV.generate do |csv|
                JSON.parse(res.body).each do |hash|
                    if i=="true"
                        csv << hash.keys
                        i="false"
                    end
                    csv << hash.values
                end
            end
            puts csv_string
        else
            puts "Veuillez saisir le format correct:json ou csv"
        end  
        rescue
            puts "une erreur est survenue"
        end
    end
end
retour=RobotApiClient.new
retour.ReponseGet("")