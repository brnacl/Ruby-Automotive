require 'edmunds_ruby'
require 'net/http'
require 'json'

class Part
  attr_accessor :part_id, :car_id, :project_id, :name, :replacement_date, :description, :manufacturer, :model_num, :vendor, :purchase_price, :warranty

  def initialize attributes={}
    [:part_id, :car_id, :project_id, :name, :replacement_date, :description, :manufacturer, :model_num, :vendor, :purchase_price, :warranty].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.find
    db = Environment.database_connection
    output = []
    begin
      statement = "SELECT * FROM Parts"
      db.execute(statement) do |row|
        data = []
        Part.attributes.each do |a|
          data << [a, row[Part.attributes.index(a)]]
        end
        part = self.new(Hash[data])
        output << part
      end
      return output
    rescue Exception=>e
      return "Error: #{e}"
    end
  end

  def create
    db = Environment.database_connection
    begin
      statement = "INSERT INTO Parts "
      statement << "(CarID,ProjectID,Name,ReplacementDate,Description,Manufacturer,ModelNumber,Vendor,PurchasePrice,Warranty) "
      statement << "VALUES ('#{car_id}', '#{project_id}', '#{name}', '#{replacement_date}', '#{description}', '#{manufacturer}', '#{model_num}', '#{vendor}', '#{purchase_price}', '#{warranty}')"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def update
    db = Environment.database_connection
    begin
      statement = "UPDATE Parts SET "
      statement << "CarID='#{car_id}', "
      statement << "ProjectID='#{project_id}', "
      statement << "Name='#{name}', "
      statement << "ReplacementDate='#{replacement_date}', "
      statement << "Description='#{description}', "
      statement << "Manufacturer='#{manufacturer}', "
      statement << "ModelNumber='#{model_num}', "
      statement << "Vendor='#{vendor}', "
      statement << "PurchasePrice='#{purchase_price}', "
      statement << "Warranty='#{warranty}' "
      statement << "WHERE PartID='#{part_id}'"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "Error: #{e}"
    end
  end

   def delete
    db = Environment.database_connection
    begin
      statement = "DELETE FROM Parts WHERE PartID='#{part_id}';"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def self.attributes
    part = Part.new
    arr = []
    part.instance_variables.each do |var|
      var = var.slice(1,var.length)
      arr << var.to_sym
    end
    arr
  end
end