require 'edmunds_ruby'
require 'net/http'
require 'json'

class Car
  attr_accessor :year, :make, :model, :trim, :purchase_mileage, :purchase_price, :current_value, :purchase_date

  def initialize year, make, model, trim, purchase_mileage, purchase_price, purchase_date
    @year = year
    @make = make
    @model = model
    @trim = trim
    @purchase_mileage = purchase_mileage
    @purchase_price = purchase_price
    @purchase_date = purchase_date
  end

  def current_value current_mileage, condition, zip
    edmunds = Edmunds::API.new
    api_key  = edmunds.api_key
    base_url = 'https://api.edmunds.com/v1/api/tmv/tmvservice/calculateusedtmv'
    s = Edmunds::Style.new
    data = s.find_styles_by_make_model_year(@make, @model, @year)

    style_id = nil
    data.each do |d|
      if d["trim"]["name"].upcase.include? @trim.upcase
        style_id = d["id"].to_s
        @trim = d["trim"]["name"]
        break
      end
    end

    if style_id.nil?
      return 0
    else
      uri = URI.parse(base_url + '?styleid='+style_id.to_s+'&condition='+condition+'&mileage='+current_mileage.to_s+'&zip='+zip.to_s+'&fmt=json&api_key=' + api_key)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      res_car = res.body
      res_car = JSON.parse(res_car)
      res_car['tmv']['totalWithOptions']['usedPrivateParty']
    end

  end

  def display

  end


end