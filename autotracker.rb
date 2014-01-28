require 'sqlite3'

Dir["lib/*.rb"].each {|file| require_relative file }
Dir["models/*.rb"].each {|file| require_relative file }

db = SQLite3::Database.new "db/ruby_auto.sqlite"

command = ""
until command == "0"
  cars = Car.find(db)
  show_cars(cars)
  command = gets.chomp
  logic_main(db,cars,command)
end
output_clear()