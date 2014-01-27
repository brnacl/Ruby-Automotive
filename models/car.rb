require 'edmunds_ruby'
require 'net/http'
require 'json'

require_relative 'project.rb'

class Car
  attr_accessor :car_id, :year, :make, :model, :trim, :purchase_mileage, :purchase_price, :purchase_date, :current_value, :current_mileage

  def initialize attributes={}
    [:car_id, :year, :make, :model, :trim, :purchase_mileage, :purchase_price, :purchase_date, :current_value, :current_mileage].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def get_current_value args
    mileage = args[0]
    condition = args[1]
    zip = args[2]
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
      if res_car['tmv'].nil?
        return "error"
      else
        res_car['tmv']['totalWithOptions']['usedPrivateParty']
      end
    end
  end

  def create db
    begin
      statement = "INSERT INTO Cars "
      statement << "(CarYear, CarMake, CarModel, CarTrim, PurchaseMileage, PurchasePrice, DateOfPurchase, CurrentValue, CurrentMileage) "
      statement << "VALUES ('#{year}','#{make}','#{model}','#{trim}','#{purchase_mileage}','#{purchase_price}','#{purchase_date}','#{current_value}','#{current_mileage}')"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end


  def self.find db
    output = []
    begin
      db.execute( "SELECT * FROM Cars") do |row|
        data = []
        Car.attributes.each do |a|
          data << [a, row[Car.attributes.index(a)]]
        end
        car = self.new(Hash[data])
        output << car
      end
      return output
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def update db
    begin
      statement = "UPDATE Cars SET "
      statement << "CarYear='#{year}', "
      statement << "CarMake='#{make}', "
      statement << "CarModel='#{model}', "
      statement << "CarTrim='#{trim}', "
      statement << "PurchaseMileage='#{purchase_mileage}', "
      statement << "PurchasePrice='#{purchase_price}', "
      statement << "DateOfPurchase='#{purchase_date}', "
      statement << "CurrentMileage='#{current_mileage}', "
      statement << "CurrentValue='#{current_value}' "
      statement << "WHERE CarID='#{car_id}'"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def delete db
    begin
      statement = "DELETE FROM Cars WHERE CarID='#{car_id}'; "
      statement << "DELETE FROM Projects WHERE CarID='#{car_id}'; "
      statement << "DELETE FROM Parts WHERE CarID='#{car_id}';"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def projects db
    output = []
    all_projects = Project.find(db)
    all_projects.each do |project|
      output << project if project.car_id == car_id
    end
    output
  end

  def self.attributes
    car = Car.new
    arr = []
    car.instance_variables.each do |var|
      var = var.slice(1,var.length)
      arr << var.to_sym
    end
    arr
  end
end
