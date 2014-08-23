require 'edmunds_ruby'
require 'net/http'
require 'json'

class Car < ActiveRecord::Base

  default_scope { order("make ASC") }

  after_initialize :init

  def init
    self.current_value ||= purchase_price
    self.current_mileage ||= purchase_mileage
  end

  def self.search(search_term = nil)
    Car.where("model LIKE ?", "%#{search_term}%").to_a
  end

  def formatted_purchase_price
    "$%04.2f" % purchase_price
  end

  def formatted_current_value
    "$%04.2f" % current_value
  end

  def formatted_purchase_date
    purchase_date.to_s
  end

  def projects
    Project.where("car_id = '#{self.id}'").to_a
  end

  def to_s
    "#{year} #{make} #{model}"
  end

  def get_current_value args
    mileage = args[0]
    condition = args[1]
    zip = args[2]
    edmunds = Edmunds::API.new
    api_key  = edmunds.api_key
    base_url = 'https://api.edmunds.com/v1/api/tmv/tmvservice/calculateusedtmv'
    s = Edmunds::Style.new
    begin
      data = s.find_styles_by_make_model_year(make, model, year)

      style_id = nil
      data.each do |d|
        if d["trim"]["name"].upcase.include? trim.upcase
          style_id = d["id"].to_s
          trim = d["trim"]["name"]
          break
        end
      end

      if style_id.nil?
        return 0
      else
        uri = URI.parse(base_url + '?styleid='+style_id.to_s+'&condition='+condition+'&mileage='+mileage.to_s+'&zip='+zip.to_s+'&fmt=json&api_key=' + api_key)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri.request_uri)
        res = http.request(req)
        res_car = res.body
        res_car = JSON.parse(res_car)
        if res_car['tmv'].nil?
          return "error"
        else
          res_car['tmv']['totalWithOptions']['usedPrivateParty']
        end
      end
    rescue Exception=>e
      return 0
    end
  end
end
