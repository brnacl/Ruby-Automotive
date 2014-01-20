require_relative 'lib/colors.rb'
require_relative 'lib/output_formatting.rb'
require_relative 'lib/db.rb'
require_relative 'lib/car.rb'

db = DB.new

output_header()

if ARGV[0].nil?
  command = nil
else
  command = ARGV[0]
end

until command == "7"
  puts "\nPlease Enter a #{red('NUMBER')}..."
  puts green("1(Show Cars)\n2(Show Projects)\n3(Show Parts)\n4(Add Car)\n5(Add Project)\n6(Add Part)\n7(Exit)")
  command = gets.to_i
  output_header()

  case command
  when 4
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
    output_header()
    puts purple("#{year} #{make} #{model} #{trim} with #{purchase_mileage} miles for $#{purchase_price} on #{purchase_date}")
    puts "Car entered successfully!"
    new_car = Car.new(year, make, model, trim, purchase_mileage, purchase_price, purchase_date)

  when 'add_project'
    puts purple("...Adding Project\n")
  when 'add_part'
    puts purple("...Adding Part\n")
  when 1
    puts purple("...Showing Cars\n")
    cars = db.get_cars
    cars.each do |car|
      puts car
    end
  when 2
    puts purple("...Showing Projects\n")
    projects = db.get_projects
    projects.each do |project|
      puts project
    end
  when 3
    puts purple("...Showing Parts\n")
    parts = db.get_parts
    parts.each do |part|
      puts part
    end
  when 7
    output_clear()
    break
  else
    puts red("Error: Invalid Command!")
  end
end