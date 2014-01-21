require 'edmunds_ruby'
require 'net/http'
require 'json'

class Car
  attr_accessor :year, :make, :model, :trim, :purchase_mileage, :purchase_price, :purchase_date, :current_value, :current_mileage

  def initialize args
    @year = args[1]
    @make = args[2]
    @model = args[3]
    @trim = args[4]
    @purchase_mileage = args[5]
    @purchase_price = args[6]
    @purchase_date = args[7]
    @current_value = args[8]
    @current_mileage = args[9]
  end

  def get_current_value mileage, condition, zip
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
      uri = URI.parse(base_url + '?styleid='+style_id.to_s+'&condition='+condition+'&mileage='+mileage.to_s+'&zip='+zip.to_s+'&fmt=json&api_key=' + api_key)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      res_car = res.body
      res_car = JSON.parse(res_car)
      res_car['tmv']['totalWithOptions']['usedPrivateParty']
    end
  end

  def db_create db
    begin
      db.connect.execute("INSERT INTO Cars (CarYear, CarMake, CarModel, CarTrim, PurchaseMileage, PurchasePrice, DateOfPurchase, CurrentValue, CurrentMileage)
                  VALUES (?,?,?,?,?,?,?,?,?)", [@year,@make,@model,@trim,@purchase_mileage,@purchase_price,@purchase_date,@current_value,@current_mileage])
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def self.db_read db,id=nil
    output = []
    if id
      begin
        db.connect.execute( "SELECT * FROM Cars WHERE CarID = " + id.to_s ) do |row|
          output << row
        end
      rescue Exception=>e
        return "An error has occured: #{e}"
      end
    else
      begin
        db.connect.execute( "SELECT * FROM Cars WHERE CarID") do |row|
          output << row
        end
      rescue Exception=>e
        return "An error has occured: #{e}"
      end
    end
    output
  end

  def db_update db,id
    begin

      db.connect.execute("UPDATE Cars SET CurrentMileage="+@current_mileage.to_s+", CurrentValue="+@current_value.to_s+" WHERE CarID="+id.to_s)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end

  end

end