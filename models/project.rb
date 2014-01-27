require 'edmunds_ruby'
require 'net/http'
require 'json'

class Project
  attr_accessor :project_id, :car_id, :title, :description, :mileage, :start_date

  def initialize attributes={}
    [:project_id, :car_id, :title, :description, :mileage, :start_date].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.find db
    output = []
    begin
      db.execute( "SELECT * FROM Projects") do |row|
        data = []
        Project.attributes.each do |a|
          data << [a, row[Project.attributes.index(a)]]
        end
        project = self.new(Hash[data])
        output << project
      end
      return output
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def create db
    begin
      statement = "INSERT INTO Projects "
      statement << "(CarID, Title, Description, Mileage, StartDate) "
      statement << "VALUES ('#{car_id}','#{title}','#{description}','#{mileage}','#{start_date}')"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def update db
    begin
      statement = "UPDATE Projects SET "
      statement << "CarID='#{car_id}', "
      statement << "Title='#{title}', "
      statement << "Description='#{description}', "
      statement << "Mileage='#{mileage}', "
      statement << "StartDate='#{start_date}' "
      statement << "WHERE ProjectID='#{project_id}'"
      db.execute(statement)
      return "Success"

    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

   def delete db
    begin
      statement = "DELETE FROM Projects WHERE ProjectID='#{project_id}'; "
      statement << "DELETE FROM Parts WHERE ProjectID='#{project_id}';"
      db.execute(statement)
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

  def self.attributes
    project = Project.new
    arr = []
    project.instance_variables.each do |var|
      var = var.slice(1,var.length)
      arr << var.to_sym
    end
    arr
  end
end