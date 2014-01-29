require 'edmunds_ruby'
require 'net/http'
require 'json'

class Car
  attr_accessor :year, :make, :model, :trim, :purchase_mileage, :purchase_price, :purchase_date, :current_value, :current_mileage
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    car = Car.new(attributes)
    car.save
    car
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    db = Environment.database_connection
    if id
      statement = "UPDATE Cars SET "
      statement << "Year='#{year}', "
      statement << "Make='#{make}', "
      statement << "Model='#{model}', "
      statement << "Trim='#{trim}', "
      statement << "PurchaseMileage='#{purchase_mileage}', "
      statement << "PurchasePrice='#{purchase_price}', "
      statement << "PurchaseDate='#{purchase_date}', "
      statement << "CurrentMileage='#{current_mileage}', "
      statement << "CurrentValue='#{current_value}' "
      statement << "WHERE ID='#{id}'"
      db.execute(statement)
    else
      statement = "INSERT INTO Cars "
      statement << "(Year, Make, Model, Trim, PurchaseMileage, PurchasePrice, PurchaseDate, CurrentValue, CurrentMileage) "
      statement << "VALUES ('#{year}','#{make}','#{model}','#{trim}','#{purchase_mileage}','#{purchase_price}','#{purchase_date}','#{current_value}','#{current_mileage}')"
      db.execute(statement)
      @id = db.last_insert_row_id
    end
  end

  def self.find id
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT * FROM Cars WHERE ID = #{id}"
    results = db.execute(statement)[0]
    if results
      car = Car.new(year: results["Year"],
                    make: results["Make"],
                    model: results["Model"],
                    trim: results["Trim"],
                    purchase_mileage: results["PurchaseMileage"],
                    purchase_price: results["PurchasePrice"],
                    purchase_date: results["PurchaseDate"],
                    current_value: results["CurrentValue"],
                    current_mileage: results["CurrentMileage"])
      car.send("id=", results["ID"])
      car
    else
      nil
    end
  end

  def self.search(search_term = nil)
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT Cars.* from Cars WHERE Make LIKE '%#{search_term}%' ORDER BY Make ASC"
    results = db.execute(statement)
    results.map do |row_hash|
      car = Car.new(year: row_hash["Year"],
                    make: row_hash["Make"],
                    model: row_hash["Model"],
                    trim: row_hash["Trim"],
                    purchase_mileage: row_hash["PurchaseMileage"],
                    purchase_price: row_hash["PurchasePrice"],
                    purchase_date: row_hash["PurchaseDate"],
                    current_value: row_hash["CurrentValue"],
                    current_mileage: row_hash["CurrentMileage"])
      car.send("id=", row_hash["ID"])
      car
    end
  end

  def delete
    db = Environment.database_connection
    begin
      statement = "DELETE FROM Cars WHERE ID='#{id}'; "
      statement << "DELETE FROM Projects WHERE CarID='#{id}'; "
      statement << "DELETE FROM Parts WHERE CarID='#{id}'"
      db.execute(statement)
    rescue Exception=>e
      e
    end
  end

  def projects
    db = Environment.database_connection
    output = []
    begin
      statement = "SELECT * FROM Projects p "
      statement << "INNER JOIN Cars c ON c.ID = p.CarID "
      statement << "WHERE c.ID = '#{id}'"
      results = db.execute(statement)
      results.map do |row_hash|
        project = Project.new(car_id: row_hash["CarID"],
                              title: row_hash["Title"],
                              description: row_hash["Description"],
                              mileage: row_hash["Mileage"],
                              start_date: row_hash["StartDate"]
                  )
        project.send("id=", row_hash["ID"])
        project
      end
    rescue Exception=>e
      e
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

  def self.all
    search
  end

  def purchase_price
    sprintf('%.2f', @purchase_price) if @purchase_price
  end

  def current_value
    sprintf('%.2f', @current_value) if @current_value
  end

  def to_s
    "#{year} #{make} #{model}"
  end

  def == (other)
    if self.to_s == other.to_s
      true
    else
      false
    end
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:year, :make, :model, :trim, :purchase_mileage, :purchase_price, :purchase_date, :current_value, :current_mileage].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
    self.send("#{:current_mileage}=", attributes[:purchase_mileage]) if current_mileage.nil?
    self.send("#{:current_value}=", attributes[:purchase_price]) if current_value.nil?
  end
end
