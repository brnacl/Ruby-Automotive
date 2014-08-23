require 'artii'

def header_car car
  puts "\nCAR: " + green("#{car.year} #{car.make} #{car.model}")
end

def header_add_car sub_header
  header_main
  menu_add_car
  puts purple(sub_header)
end

def header_car_value car,sub_header
  header_main
  menu_car_value
  header_car(car)
  puts purple(sub_header)
end

def menu_cars num_cars
  menu = "\nMAIN MENU > "
  menu << green("1..#{num_cars}")+"(Select Car) " if num_cars > 0
  menu << green("+")+"(Add New Car) "
  menu << red("0")+"(Exit)"
  puts menu
end

def menu_car
  menu = "\nCAR MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1")+"(Get Current Value) "
  menu << green("2")+"(Show Projects) "
  menu << red("3")+"(Delete Car)"
  puts menu
end

def menu_add_car
  menu = "\nADD CAR > "
  menu << red("0")+"(Cancel)\n\n"
  puts menu
end

def menu_car_value
  menu = "\nCAR - CURRENT VALUE > "
  menu << green("0")
  menu << "('#{red("CANCEL")}')"
  puts menu
end

def menu_car_value_save
  menu = "\nSAVE CURRENT VALUE? > "
  menu << green("1")+"(Save) "
  menu << red("2")+"(Cancel)"
  puts menu
end

def show_cars cars
  header_main
  menu_cars(cars.length)
  if cars.length > 0
    puts "\nCARS\n"
    i = 1
    cars.each do |car|
      puts "\t#{i}. #{yellow(car.to_s)}"
      i += 1
    end
  else
    puts red("\nNO CARS FOUND")
  end
end

def show_car car
  header_main
  menu_car
  header_car(car)
  details = "\n\tTrim Package:\t\t"+yellow(car.trim)+"\n"
  details << "\n\tPurchase Mileage:\t"+yellow(car.purchase_mileage.to_s)+"\n"
  details << "\n\tPurchase Price:\t\t"+yellow(car.formatted_purchase_price)+"\n"
  details << "\n\tPurchase Date:\t\t"+yellow(car.formatted_purchase_date)+"\n"
  details << "\n\tCurrent Mileage:\t"+yellow(car.current_mileage.to_s)+"\n"
  details << "\n\tCurrent Value:\t\t"+yellow(car.formatted_current_value)+"\n"
  puts details
end

def get_car_value car
  sub_header = ""
  header_car_value(car,sub_header)
  input = []
  puts "\n\nEnter current mileage:"
  input[0] = gets.to_i
  return false if input[0] == 0
  sub_header << "\n#{input[0]} "
  header_car_value(car,sub_header)
  condition_values = ["Cancel","Outstanding","Clean","Average","Rough","Damaged"]
  options = "\nEnter current condition "
  options << green("1")+"(#{condition_values[1]}) | "
  options << green("2")+"(#{condition_values[2]}) | "
  options << green("3")+"(#{condition_values[3]}) | "
  options << green("4")+"(#{condition_values[4]}) | "
  options << green("5")+"(#{condition_values[5]})"
  puts options
  input[1] = gets.to_i
  return false if input[1] == 0
  sub_header << "#{input[1]} "
  header_car_value(car,sub_header)
  condition = condition_values[input[1]]
  input[1] = condition
  puts "\nEnter current zip-code:"
  input[2] = gets.chomp
  return false if input[2].to_i == 0
  sub_header << "#{input[2]}"
  header_car_value(car,sub_header)
  puts green("\nGetting current value...")
  current_value = car.get_current_value(input)
  return false if current_value == 0
  header_car_value(car,sub_header)
  puts "\nCurrent value is "+blue("$#{current_value}")
  current_info = [current_value,input[0]]
  return current_info
end


def add_car
  sub_header = ""
  header_add_car(sub_header)
  new_car = []
  puts "\nEnter vehicle year (2006):"
  new_car[0] = gets.chomp
  return false if new_car[0] == "0"
  sub_header << "#{new_car[0]}\s"
  header_add_car(sub_header)
  puts "\nEnter vehicle make (Volkswagen):"
  new_car[1] = gets.chomp
  return false if new_car[1] == "0"
  sub_header << "#{new_car[1]}\s"
  header_add_car(sub_header)
  puts "\nEnter vehicle model (Jetta):"
  new_car[2] = gets.chomp
  return false if new_car[2] == "0"
  sub_header << "#{new_car[2]}\s"
  header_add_car(sub_header)
  puts "\nEnter vehicle trim package (LX, 2.5, Quattro):"
  new_car[3] = gets.chomp
  return false if new_car[3] == "0"
  sub_header << "#{new_car[3]}\s"
  header_add_car(sub_header)
  puts "\nEnter vehicle original purchase mileage (100000):"
  new_car[4] = gets.chomp
  return false if new_car[4] == "0"
  sub_header << "with #{new_car[4]} miles\s"
  header_add_car(sub_header)
  puts "\nEnter vehicle original purchase price (8000.00):"
  new_car[5] = sprintf('%.2f', gets.chomp)
  return false if new_car[5] == "0"
  sub_header << "purchased for $#{new_car[5]}\s"
  header_add_car(sub_header)
  puts "\nEnter vehicle original purchase date (mm/dd/yyyy):"
  new_car[6] = gets.chomp
  return false if new_car[6] == "0"
  sub_header << "on #{new_car[6]}\s"
  header_add_car(sub_header)
  car = Car.new(year: new_car[0], make: new_car[1], model: new_car[2], trim: new_car[3], purchase_mileage: new_car[4], purchase_price: new_car[5], purchase_date: new_car[6])
  puts "\nSave Car: "+green("1")+"(YES) "+red("2")+"(NO)"
  confirm = 0
  until confirm == 1
      confirm = gets.to_i
      return false if confirm == 2
  end
  car
end