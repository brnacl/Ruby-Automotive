#!/usr/bin/env ruby

require_relative 'lib/environment'

Dir["lib/*.rb"].each {|file| require_relative file }
Dir["models/*.rb"].each {|file| require_relative file }

Environment.environment = "production"
Environment.connect_to_database

command = ""
until command == "0"
  cars = Car.all
  show_cars(cars)
  logic = Logic.new(cars: cars)
  command = gets.chomp
  logic.logic_main(command)
end
clear_screen