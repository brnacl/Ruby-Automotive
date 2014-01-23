require_relative 'car.rb'

def output_clear
  puts "\e[H\e[2J"
end

def output_header
  output_clear()
  puts blue("RUBY AUTO REPAIR TRACKER")
  puts blue("========================")
end

def output_main_menu
  menu = "MAIN MENU > "
  menu << green("1")+"(Show Cars) | "
  menu << green("2")+"(Show Projects) | "
  menu << green("3")+"(Add Car) | "
  menu << green("4")+"(Add Project) | "
  menu << red("5")+"(Exit)"
  puts menu
end

def output_all_cars_menu num_cars
  menu = "\nCARS MENU > "
  menu << green("0")+"(Main Menu) | "
  menu << green("1..#{num_cars}")+"(Select Car)"
  puts menu

end

def output_car_menu
  menu = "\nCAR MENU > "
  menu << green("0")+"(Main Menu) | "
  menu << green("1")+"(Update Current Value) | "
  menu << red("2")+"(Delete Car)"
  puts menu
end

def output_car_update_value car
  puts "\nEnter \""+green("0")+"\" to "+red("CANCEL")
  puts "\nEnter current mileage:"
  current_mileage = gets.to_i
  return false if current_mileage == 0
  condition_values = ["Cancel","Outstanding","Clean","Average","Rough","Damaged"]
  options = "\nEnter current condition "
  options << green("1")+"(#{condition_values[1]}) | "
  options << green("2")+"(#{condition_values[2]}) | "
  options << green("3")+"(#{condition_values[3]}) | "
  options << green("4")+"(#{condition_values[4]}) | "
  options << green("5")+"(#{condition_values[5]})"
  puts options

  condition_input = gets.to_i
  return false if condition_input == 0
  condition = condition_values[condition_input]

  puts "\nEnter current zip-code:"
  zip_code = gets.to_i
  return false if zip_code == 0
  puts green("\nGetting current value...")
  current_value = car.get_current_value(current_mileage,condition,zip_code)
  return false if current_value == "error"
  puts "\nCurrent value is "+blue("$#{current_value}")
  output_car_menu_update_value()
  current_info = [current_value,current_mileage]
  return current_info
end

def output_car_menu_update_value
  menu = "\nUPDATE MENU > "
  menu << green("1")+"(Update Current Value) | "
  menu << red("2")+"(Cancel Update)"
  puts menu
end

def output_all_cars  db
  puts "CARS\n"
  cars = Car.db_read(db)
  i = 1
  ids = [0]
  cars.each do |car|
    puts "\t#{i}. "+yellow("#{car[1]} #{car[2]} #{car[3]}")
    ids << car[0]
    i += 1
  end
  ids
end

def output_car_details details
  output = ">> "+yellow("#{details[1]} #{details[2]} #{details[3]}\n\n")
  output << "\tTrim Package:\t\t"+yellow(details[4])+"\n"
  output << "\tPurchase Mileage:\t"+yellow(details[5].to_s)+"\n"
  output << "\tPurchase Price:\t\t"+yellow("$"+details[6].to_s)+"\n"
  output << "\tPurchase Date:\t\t"+yellow(details[7])+"\n"
  output << "\tCurrent Mileage:\t"+yellow(details[9].to_s)+"\n"
  output << "\tCurrent Value:\t\t"+yellow("$"+details[8].to_s)+"\n"
  puts output
end

def output_add_car db
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

def output_car_confirm_delete
  puts red("\nDELETE THIS CAR:") + "Are you sure?"
  puts green("1")+"(Cancel) | "+ red("9")+"(DELETE)"
  confirm = gets.to_i
  return true if confirm == 9
  return false if confirm == 1
end