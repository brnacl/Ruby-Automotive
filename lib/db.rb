require 'sqlite3'

class DB
  attr_accessor :db

  def initialize
    @db = SQLite3::Database.new "data/ruby_auto.sqlite"
  end

  def get_cars
    output = []
    @db.execute( "SELECT * FROM Cars" ) do |row|
      output << "#{row[0]} #{row[4]} #{row[1]} #{row[2]} #{row[3]} #{row[5]} #{row[6]} #{row[8]}"
    end
    output
  end

  def get_projects
    output = []
    @db.execute( "SELECT c.CarYear, c.CarMake, c.CarModel, p.Title, part.Name, part.PurchasePrice FROM Cars c INNER JOIN Parts part ON c.CarID = part.CarID JOIN Projects p ON p.ProjectID = part.ProjectID" ) do |row|
      output << "#{row[0]} #{row[1]} #{row[2]} | #{row[3]} | #{row[4]} | $#{row[5]}"
    end
    output
  end

  def get_parts
    output = []
    @db.execute( "SELECT * FROM Parts" ) do |row|
      output << "#{row[0]} #{row[1]} #{row[2]} #{row[3]} #{row[9]}"
    end
    output
  end

end