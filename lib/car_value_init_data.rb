require 'edmunds_ruby'
require 'net/http'
require 'json'

car = {}
edmunds = Edmunds::API.new
api_key  = edmunds.api_key
base_url = 'https://api.edmunds.com/v1/api/tmv/tmvservice/calculateusedtmv'
puts 'Enter vehicle make (Volkswagen):'
car["make"] = gets.chomp
puts 'Enter vehicle model (Jetta):'
car["model"] = gets.chomp
puts 'Enter vehicle year (2006):'
car["year"] = gets.chomp
puts 'Enter vehicle trim package (LX, 2.5, Quattro):'
car["trim"] = gets.chomp
puts 'Enter vehicle mileage (100000):'
car["mileage"] = gets.chomp
puts 'Enter vehicle condition (Outstanding, Clean, Average, Rough, Damaged):'
car["condition"] = gets.chomp
puts 'Enter zip code (37206):'
car["zip"] = gets.chomp

s = Edmunds::Style.new
data = s.find_styles_by_make_model_year(car["make"], car["model"], car["year"])

data.each do |d|
  if d["trim"]["name"].upcase.include? car["trim"].upcase
    car["id"] = d["id"].to_s
    car["trim"] = d["trim"]["name"]
    break
  end
end

uri = URI.parse(base_url + '?styleid='+car["id"]+'&condition='+car["condition"]+'&mileage='+car["mileage"]+'&zip='+car["zip"]+'&fmt=json&api_key=' + api_key)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
req = Net::HTTP::Get.new(uri.request_uri)
res = http.request(req)
res_car = res.body
res_car = JSON.parse(res_car)
value = res_car['tmv']['totalWithOptions']
puts "Value : $#{value['usedPrivateParty']}"
