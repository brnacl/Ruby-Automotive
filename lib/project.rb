require 'edmunds_ruby'
require 'net/http'
require 'json'


class Project
  attr_accessor :project_id,:car_id, :title, :description, :mileage, :start_date

  def initialize args
    @project_id = args[0]
    @car_id = args[1]
    @title = args[2]
    @description = args[3]
    @mileage = args[4]
    @start_date = args[5]
  end

  def self.db_read db,id=nil
    output = []
    if id
      begin
        db.execute( "SELECT * FROM Projects WHERE ProjectID = " + id.to_s ) do |row|
          output << row
        end
      rescue Exception=>e
        return "An error has occured: #{e}"
      end
    else
      begin
        db.execute("SELECT c.CarYear, c.CarMake, c.CarModel, p.Title, p.StartDate
                  FROM Cars c
                  INNER JOIN Projects p ON p.CarID = c.CarID") do |row|
          output << row
        end
      rescue Exception=>e
        return "An error has occured: #{e}"
      end
    end
    output
  end

  def db_create db
    begin
      db.execute("INSERT INTO Projects (CarID, Title, Description, Mileage, StartDate)
                  VALUES (?,?,?,?,?)", [@car_id,@title,@description,@mileage,@start_date])
      return "Success"
    rescue Exception=>e
      return "An error has occured: #{e}"
    end
  end

end