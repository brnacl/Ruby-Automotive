require_relative 'lib/colors.rb'
require_relative 'lib/output_formatting.rb'
require_relative 'lib/car.rb'

output_header()

if ARGV[0].nil?
  command = ""
else
  command = ARGV[0]
end

until command.downcase == "exit"
  puts yellow("\nPlease Enter a Command:") + blue("(add_car, add_project, add_part, show_cars, show_projects, show_parts, exit)")
  command = gets.chomp.downcase
  output_header()

  case command
  when 'add_car'
    puts "\nEnter vehicle year (2006):"
    year = gets.chomp
    output_header()
    puts purple("#{year}")
    puts "Enter vehicle make (Volkswagen):"
    make = gets.chomp
    output_header()
    puts purple("#{year} #{make}")
    puts "Enter vehicle model (Jetta):"
    model = gets.chomp
    output_header()
    puts purple("#{year} #{make} #{model}")
    puts "Enter vehicle trim package (LX, 2.5, Quattro):"
    trim = gets.chomp
    output_header()
    puts purple("#{year} #{make} #{model} #{trim}")
    puts "Enter vehicle original purchase mileage (100000):"
    purchase_mileage = gets.chomp
    output_header()
    puts purple("#{year} #{make} #{model} #{trim} with #{purchase_mileage} miles")
    puts "Enter vehicle original purchase price (8000.00):"
    purchase_price = gets.chomp
    output_header()
    puts purple("#{year} #{make} #{model} #{trim} with #{purchase_mileage} miles for $#{purchase_price}")
    puts "Enter vehicle original purchase date (mm/dd/yyyy):"
    purchase_date = gets.chomp
    new_car = Car.new(year, make, model, trim, purchase_mileage, purchase_price, purchase_date)

    output_header
    puts purple("#{year} #{make} #{model} #{trim} with #{purchase_mileage} miles for $#{purchase_price} on #{purchase_date}")
    puts "Car entered successfully!"

  when 'add_project'
    puts purple("...Adding Project")
  when 'add_part'
    puts purple("...Adding Part")
  when 'show_cars'
    puts purple("...Showing Cars")
  when 'show_projects'
    puts purple("...Showing Projects")
  when 'show_parts'
    puts purple("...Showing Parts")
  when 'exit'
    puts "\e[H\e[2J"
    break
  else
    puts red("Error: Invalid Command!") if command.downcase != "exit"
  end
end