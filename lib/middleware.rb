require_relative 'car.rb'
require_relative 'project.rb'

def output_clear
  puts "\e[H\e[2J"
end

def output_header
  output_clear()
  puts blue("RUBY AUTO REPAIR TRACKER")
  puts blue("========================")
end

def output_main_menu
  menu = "\nMAIN MENU > "
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
  output_car_menu_get_value()
  output_car_details(car)
  input = []
  puts "\n\n\nEnter current mileage:"
  input[0] = gets.to_i
  return false if input[0] == 0
  output_header()
  output_car_menu_get_value()
  output_car_details(car)
  puts purple("\n#{input[0]}")
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
  condition = condition_values[input[1]]
  input[1] = condition
  output_header()
  output_car_menu_get_value()
  output_car_details(car)
  puts purple("\n#{input[0]} #{input[1]}")
  puts "\nEnter current zip-code:"
  input[2] = gets.to_i
  return false if input[2] == 0
  output_header()
  output_car_menu_get_value()
  output_car_details(car)
  puts purple("\n#{input[0]} #{input[1]} #{input[2]}")
  puts green("\nGetting current value...")
  current_value = car.get_current_value(input)
  return false if current_value == "error"
  output_header()
  output_car_menu_update_value()
  output_car_details(car)
  puts purple("\n#{input[0]} #{input[1]} #{input[2]}")
  puts "\nCurrent value is "+blue("$#{current_value}")

  current_info = [current_value,input[0]]
  return current_info
end

def output_car_menu_get_value
  menu = "\nUPDATE CAR VALUE > Enter \""
  menu << green("0")+"\" to "
  menu << red("CANCEL")
  puts menu
end

def output_car_menu_update_value
  menu = "\nUPDATE CAR VALUE > "
  menu << green("1")+"(Update Current Value) | "
  menu << red("2")+"(Cancel Update)"
  puts menu
end

def output_all_cars  cars
  puts "\nCARS\n"
  i = 1
  ids = [0]
  cars.each do |car|
    puts "\t#{i}. "+yellow("#{car.year} #{car.make} #{car.model}")
    ids << car.car_id
    i += 1
  end
  return ids
end

def output_car_details car
  output = "\n>> "+yellow("#{car.year} #{car.model} #{car.make}\n\n")
  output << "\tTrim Package:\t\t"+yellow(car.trim)+"\n"
  output << "\tPurchase Mileage:\t"+yellow(car.purchase_mileage.to_s)+"\n"
  output << "\tPurchase Price:\t\t"+yellow("$"+car.purchase_price.to_s)+"\n"
  output << "\tPurchase Date:\t\t"+yellow(car.purchase_date)+"\n"
  output << "\tCurrent Mileage:\t"+yellow(car.current_mileage.to_s)+"\n"
  output << "\tCurrent Value:\t\t"+yellow("$"+car.current_value.to_s)+"\n"
  puts output
end

def output_add_car_menu
  menu = "\nADD CAR > "
  menu << red("0")+"(Cancel)\n\n"
  puts menu
end

def output_add_car db
  new_car = []
  new_car[0] = 0
  output_add_car_menu()
  puts "\n\nEnter vehicle year (2006):"
  new_car[1] = gets.chomp
  return false if new_car[1] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]}")
  puts "\nEnter vehicle make (Volkswagen):"
  new_car[2] = gets.chomp
  return false if new_car[2] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]} #{new_car[2]}")
  puts "\nEnter vehicle model (Jetta):"
  new_car[3] = gets.chomp
  return false if new_car[3] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]}")
  puts "\nEnter vehicle trim package (LX, 2.5, Quattro):"
  new_car[4] = gets.chomp
  return false if new_car[4] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]}")
  puts "\nEnter vehicle original purchase mileage (100000):"
  new_car[5] = gets.chomp
  return false if new_car[5] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]} with #{new_car[5]} miles")
  puts "\nEnter vehicle original purchase price (8000.00):"
  new_car[6] = gets.chomp
  return false if new_car[6] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]} with #{new_car[5]} miles, purchased for $#{new_car[6]}")
  puts "\nEnter vehicle original purchase date (mm/dd/yyyy):"
  new_car[7] = gets.chomp
  return false if new_car[7] == "0"
  output_header()
  output_add_car_menu()
  puts purple("#{new_car[1]} #{new_car[2]} #{new_car[3]} #{new_car[4]} with #{new_car[5]} miles, purchased for $#{new_car[6]} on $#{new_car[7]}")
  new_car[8] = 0
  new_car[9] = 0
  new_car = Car.new(new_car)
  puts "\nSave Car: "+green("1")+"(YES) "+red("2")+"(NO)"
  confirm = 0
  until confirm == 1
      confirm = gets.to_i
      return false if confirm == 2
  end
  new_car.db_create(db)
end

def output_car_confirm_delete
  puts red("\nDELETE THIS CAR:") + "Are you sure?"
  puts green("1")+"(Cancel) | "+ red("9")+"(DELETE)"
  confirm = gets.to_i
  return true if confirm == 9
  return false if confirm == 1
end

def output_all_projects  db
  puts "PROJECTS\n"
  projects = Project.db_read(db)
  i = 1
  ids = [0]
  projects.each do |project|
    puts "\t#{i}. "+yellow("#{project[0]} #{project[1]} #{project[2]}, #{project[3]}, #{project[4]}")
    ids << project[0]
    i += 1
  end
  ids
end

def output_all_projects_menu num_projects
  menu = "\nCARS MENU > "
  menu << green("0")+"(Main Menu) | "
  menu << green("1..#{num_projects}")+"(Select Project)"
  puts menu
end

def output_add_project_cars db
  puts "ADD PROJECT - SELECT CAR\n"
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

def output_add_project_car_header db,car_id
  car = Car.db_read(db,car_id)[0]
  header = "Car: " + green("#{car[1]} #{car[2]} #{car[3]}")
  return header
end

def output_add_project db,car_id,header
  puts header
  new_project = []
  new_project[0] = 0
  new_project[1] = car_id
  puts "\nEnter a title for this new project..."
  new_project[2] = gets.chomp
  sub_header_title = "Project: #{green(new_project[2])}"
  output_header()
  puts header
  puts sub_header_title
  puts "\nEnter a description:"
  new_project[3] = gets.chomp
  sub_header_description = "Description: #{green(new_project[3])}"
  output_header()
  puts header
  puts sub_header_title
  puts sub_header_description
  puts "\nEnter current vehicle mileage..."
  new_project[4] = gets.chomp
  sub_header_mileage = "Mileage: #{green(new_project[4])}"
  output_header()
  puts header
  puts sub_header_title
  puts sub_header_description
  puts sub_header_mileage
  puts "\nEnter the start date for the project..."
  new_project[5] = gets.chomp
  new_project = Project.new(new_project)
  new_project.db_create(db)
end