require_relative '../models/car.rb'
require_relative '../models/project.rb'
require_relative '../models/part.rb'

def output_clear
  puts "\e[H\e[2J"
end

def output_header
  output_clear()
  puts blue("RUBY AUTO REPAIR TRACKER")
  puts blue("========================")
end

def output_main_menu num_cars
  menu = "\nMAIN MENU > "
  menu << green("1..#{num_cars}")+"(Select Car) "
  menu << green("+")+"(Add New Car) "
  menu << red("0")+"(Exit)"
  puts menu
end

def output_all_projects_cars_menu num_cars
  menu = "\nPROJECTS MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1..#{num_cars}")+"(Select Car)"
  puts menu
end

def output_car_menu
  menu = "\nCAR MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1")+"(Get Current Value) "
  menu << green("2")+"(Show Projects) "
  menu << red("3")+"(Delete Car)"
  puts menu
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

def output_car_header car
  header = "\nCar: " + green("#{car.year} #{car.make} #{car.model}")
  return header
end

def output_project_header project
  header = "\nProject: " + green("#{project.title}, #{project.start_date}, #{project.mileage}")
  return header
end

def output_project_menu
  menu = "\nPROJECT MENU > "
  menu << green("0")+"(Main Menu) | "
  menu << green("1")+"(Show Project Parts) | "
  menu << red("2")+"(Delete Project)"
  puts menu
end

def output_part_menu
  menu = "\nPART MENU > "
  menu << green("0")+"(Main Menu) "
  menu << red("1")+"(Delete Part)"
  puts menu
end

def output_project_details car,project
  puts output_car_header(car)
  output = "\n\tProject:\t"+yellow(project.title)+"\n\n"
  output << "\tDescription:\t"+yellow(project.description)+"\n\n"
  output << "\tMileage:\t"+yellow(project.mileage)+"\n\n"
  output << "\tStart Date:\t"+yellow(project.start_date)+"\n\n"
  puts output
end

def output_part_details car,project,part
  puts output_car_header(car)
  puts output_project_header(project)
  output = "\n\tPart:\t"+yellow(part.name)+"\n\n"
  output << "\tDescription:\t"+yellow(part.description)+"\n\n"
  output << "\tManufacturer:\t"+yellow(part.manufacturer)+"\n\n"
  output << "\tModel No.:\t"+yellow(part.model_num)+"\n\n"
  output << "\tReplaced:\t"+yellow(part.replacement_date)+"\n\n"
  output << "\tWarranty:\t"
  output << part.warranty ? "Yes\n\n" : "No\n\n"
  puts output
end

def output_all_cars cars
  puts "\nCARS\n"
  i = 1
  cars.each do |car|
    puts "\t#{i}. "+yellow("#{car.year} #{car.make} #{car.model}")
    i += 1
  end
end

def output_car_details car
  puts output_car_header(car)
  output = "\tTrim Package:\t\t"+yellow(car.trim)+"\n"
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
  input[2] = gets.chomp
  return false if input[2].to_i == 0
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


def output_add_car
  car_info = ""
  new_car = []
  new_car[0] = 0
  output_add_car_menu()
  puts "\n\nEnter vehicle year (2006):"
  new_car[1] = gets.chomp
  return false if new_car[1] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "#{new_car[1]}\s")
  puts "\nEnter vehicle make (Volkswagen):"
  new_car[2] = gets.chomp
  return false if new_car[2] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "#{new_car[2]}\s")
  puts "\nEnter vehicle model (Jetta):"
  new_car[3] = gets.chomp
  return false if new_car[3] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "#{new_car[3]}\s")
  puts "\nEnter vehicle trim package (LX, 2.5, Quattro):"
  new_car[4] = gets.chomp
  return false if new_car[4] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "#{new_car[4]}\s")
  puts "\nEnter vehicle original purchase mileage (100000):"
  new_car[5] = gets.chomp
  return false if new_car[5] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "with #{new_car[5]} miles\s")
  puts "\nEnter vehicle original purchase price (8000.00):"
  new_car[6] = gets.chomp
  return false if new_car[6] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "purchased for $#{new_car[6]}\s")
  puts "\nEnter vehicle original purchase date (mm/dd/yyyy):"
  new_car[7] = gets.chomp
  return false if new_car[7] == "0"
  output_header()
  output_add_car_menu()
  puts purple(car_info << "on #{new_car[7]}\s")
  new_car[8] = 0
  new_car[9] = 0
  data = []
  Car.attributes.each do |a|
    data << [a, new_car[Car.attributes.index(a)]]
  end
  new_car = Car.new(Hash[data])
  puts "\nSave Car: "+green("1")+"(YES) "+red("2")+"(NO)"
  confirm = 0
  until confirm == 1
      confirm = gets.to_i
      return false if confirm == 2
  end
  return new_car
end

def output_confirm_delete
  puts red("\nDELETE:") + "Are you sure?"
  puts green("1")+"(Cancel) | "+ red("9")+"(DELETE)"
  confirm = gets.to_i
  return true if confirm == 9
  return false if confirm == 1
end

def output_car_projects car, projects
  menu = "\nPROJECTS MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1..#{projects.length}")+"(Select Project) " if projects.length > 0
  menu << green("+") + "(Add Project)"
  puts menu

  puts green("\n#{car.year} #{car.make} #{car.model}\n")

  if projects.length > 0
    puts "PROJECTS\n"
    i = 1
    projects.each do |project|
      puts "\t#{i}. "+yellow("#{project.title} #{project.start_date}")
      i += 1
    end
  else
    puts red("NO PROJECTS")

  end
end

def output_project_parts car, project, parts
  menu = "\nPROJECTS - PARTS MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1..#{parts.length}")+"(Select Parts) " if parts.length > 0
  menu << green("+") + "(Add Part)"
  puts menu

  puts green("\n#{car.year} #{car.make} #{car.model}: #{project.title}, #{project.start_date}, #{project.mileage} miles\n")

  if parts.length > 0
    puts "PARTS\n"
    i = 1
    parts.each do |part|
      puts "\t#{i}. "+yellow("#{part.name}, #{part.manufacturer}")
      i += 1
    end
  else
    puts red("NO PARTS")
  end
end

def output_all_projects_menu num_projects
  menu = "\nPROJECTS MENU > "
  menu << green("0")+"(Main Menu) | "
  menu << green("1..#{num_projects}")+"(Select Project)"
  puts menu
end

def output_car_projects_menu num_projects

end

def output_add_project_cars db
  puts "ADD PROJECT - SELECT CAR\n\n"
  cars = Car.db_read(db)
  i = 1
  ids = [0]
  cars.each do |car|
    puts "\t#{i}. " + yellow("#{car.year} #{car.make} #{car.model}")
    ids << car.car_id
    i += 1
  end
  ids
end

def output_add_project car,car_info_header
  puts car_info_header
  new_project = []
  new_project[0] = 0
  new_project[1] = car.car_id
  puts "\nEnter a title for this new project..."
  new_project[2] = gets.chomp
  sub_header_title = "\tProject: #{green(new_project[2])}"
  output_header()
  puts car_info_header
  puts sub_header_title
  puts "\nEnter a description:"
  new_project[3] = gets.chomp
  sub_header_description = "\tDescription: #{green(new_project[3])}"
  output_header()
  puts car_info_header
  puts sub_header_title
  puts sub_header_description
  puts "\nEnter vehicle mileage..."
  new_project[4] = gets.chomp
  sub_header_mileage = "\tMileage: #{green(new_project[4])}"
  output_header()
  puts car_info_header
  puts sub_header_title
  puts sub_header_description
  puts sub_header_mileage
  puts "\nEnter the start date for the project..."
  new_project[5] = gets.chomp
  sub_header_date = "\tStart Date: #{green(new_project[5])}"
  output_header()
  puts car_info_header
  puts sub_header_title
  puts sub_header_description
  puts sub_header_mileage
  puts sub_header_date
  data = []
  Project.attributes.each do |a|
    data << [a, new_project[Project.attributes.index(a)]]
  end
  new_project = Project.new(Hash[data])
  puts "\nSave Project: "+green("1")+"(YES) "+red("2")+"(NO)"
  confirm = 0
  until confirm == 1
      confirm = gets.to_i
      return false if confirm == 2
  end
  return new_project
end

def output_add_part car,project
  main_header = "#{output_car_header(car)}: "
  main_header << "#{output_project_header(project)}\n"
  puts main_header
  new_part = []
  new_part[0] = 0
  new_part[1] = car.car_id
  new_part[2] = project.project_id
  puts "\nEnter a name for this new part..."
  new_part[3] = gets.chomp
  sub_header = "\tPart: #{green(new_part[3])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nEnter replacement date:"
  new_part[4] = gets.chomp
  sub_header << "\tReplaced: #{green(new_part[4])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nEnter a description:"
  new_part[5] = gets.chomp
  sub_header << "\tDescription: #{green(new_part[5])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nEnter the part manufacturer:"
  new_part[6] = gets.chomp
  sub_header << "\tManufacturer: #{green(new_part[6])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nEnter the model number:"
  new_part[7] = gets.chomp
  sub_header << "\tModel No.: #{green(new_part[7])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nEnter the part vendor:"
  new_part[8] = gets.chomp
  sub_header << "\tVendor: #{green(new_part[8])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nEnter the purchase price:"
  new_part[9] = gets.chomp
  sub_header << "\tPrice: #{green(new_part[9])}\n"
  output_header()
  puts main_header
  puts sub_header
  puts "\nIs there a warranty? ('#{green("Y")}' / '#{red("N")}'')}'):"
  new_part[10] = gets.chomp
  new_part[10] = new_part[10].downcase == "y" ? true : false
  sub_header << "\tWarranty: #{green(new_part[10])}\n"
  output_header()
  puts main_header
  puts sub_header
  data = []
  Part.attributes.each do |a|
    data << [a, new_part[Part.attributes.index(a)]]
  end
  new_part = Part.new(Hash[data])
  puts "\nSave Part: "+green("1")+"(YES) "+red("2")+"(NO)"
  confirm = 0
  until confirm == 1
      confirm = gets.to_i
      return false if confirm == 2
  end
  return new_part
end