
require_relative 'car.rb'

def add_car db
  new_car = []
  puts "\nEnter vehicle year (2006):"
  new_car[1] = gets.chomp
  output_header()
  puts purple("#{new_car[1]}")
  puts "Enter vehicle make (Volkswagen):"
  new_car[2] = gets.chomp
  output_header()
  puts purple("#{new_car[1]} #{new_car[2]}")
  puts "Enter vehicle model (Jetta):"
  new_car[3] = gets.chomp
  output_header()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]}")
  puts "Enter vehicle trim package (LX, 2.5, Quattro):"
  new_car[4] = gets.chomp
  output_header()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]}")
  puts "Enter vehicle original purchase mileage (100000):"
  new_car[5] = gets.chomp
  output_header()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]} with #{new_car[5]} miles")
  puts "Enter vehicle original purchase price (8000.00):"
  new_car[6] = gets.chomp
  output_header()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]} with #{new_car[5]} miles, purchased for $#{new_car[6]}")
  puts "Enter vehicle original purchase date (mm/dd/yyyy):"
  new_car[7] = gets.chomp
  output_header()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]} with #{new_car[5]} miles, purchased for $#{new_car[6]} on $#{new_car[7]}")
  puts "Car entered successfully!"
  new_car[8] = 0
  new_car[9] = 0
  new_car[10] = ""
  new_car[11] = 0
  new_car = Car.new(new_car)
  new_car.db_create(db)
end

def get_cars db
  puts "CARS\n"
  cars = Car.db_read(db)
  i = 1
  ids = [0]
  cars.each do |car|
    puts "#{i}. "+yellow("#{car[1]} #{car[2]} #{car[3]}")
    ids << car[0]
    i += 1
  end
  ids
end