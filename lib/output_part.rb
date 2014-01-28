def header_part part
  puts "\nPART: " + green("#{part.name}, #{part.manufacturer}, #{part.replacement_date}")
end

def header_add_part car,project,sub_header
  header_main()
  menu_add_part()
  header_car(car)
  header_project(project)
  puts purple(sub_header)
end

def menu_parts num_parts
  menu = "\nPROJECTS - PARTS MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1..#{num_parts}")+"(Select Parts) " if num_parts > 0
  menu << green("+") + "(Add Part)"
  puts menu
end

def menu_part
  menu = "\nPART MENU > "
  menu << green("0")+"(Main Menu) "
  menu << red("1")+"(Delete Part)"
  puts menu
end

def menu_add_part
  menu = "\nADD PART > "
  menu << red("0")+"(Cancel)\n\n"
  puts menu
end

def show_parts car, project, parts
  header_main()
  menu_parts(parts.length)
  header_car(car)
  header_project(project)
  if parts.length > 0
    puts "\nPARTS:\n"
    i = 1
    parts.each do |part|
      puts "\t#{i}. "+yellow("#{part.name}, #{part.manufacturer}")
      i += 1
    end
  else
    puts red("NO PARTS")
  end
end

def show_part car,project,part
  header_main()
  menu_part()
  header_car(car)
  header_project(project)
  details = "\n\tPart:\t"+yellow(part.name)+"\n\n"
  details << "\n\tDescription:\t"+yellow(part.description)+"\n\n"
  details << "\n\tManufacturer:\t"+yellow(part.manufacturer)+"\n\n"
  details << "\n\tModel No.:\t"+yellow(part.model_num)+"\n\n"
  details << "\n\tReplaced:\t"+yellow(part.replacement_date)+"\n\n"
  details << "\n\tWarranty:\t"
  details << part.warranty ? "Yes\n\n" : "No\n\n"
  puts details
end

def add_part car,project
  sub_header = ""
  header_add_part(car,project,sub_header)
  new_part = []
  new_part[0] = 0
  new_part[1] = car.car_id
  new_part[2] = project.project_id
  puts "\nEnter a name for this new part..."
  new_part[3] = gets.chomp
  sub_header << "\tPart: #{green(new_part[3])}\n"
  header_add_part(car,project,sub_header)
  puts "\nEnter replacement date:"
  new_part[4] = gets.chomp
  sub_header << "\tReplaced: #{green(new_part[4])}\n"
  header_add_part(car,project,sub_header)
  puts "\nEnter a description:"
  new_part[5] = gets.chomp
  sub_header << "\tDescription: #{green(new_part[5])}\n"
  header_add_part(car,project,sub_header)
  puts "\nEnter the part manufacturer:"
  new_part[6] = gets.chomp
  sub_header << "\tManufacturer: #{green(new_part[6])}\n"
  header_add_part(car,project,sub_header)
  puts "\nEnter the model number:"
  new_part[7] = gets.chomp
  sub_header << "\tModel No.: #{green(new_part[7])}\n"
  header_add_part(car,project,sub_header)
  puts "\nEnter the part vendor:"
  new_part[8] = gets.chomp
  sub_header << "\tVendor: #{green(new_part[8])}\n"
  header_add_part(car,project,sub_header)
  puts "\nEnter the purchase price:"
  new_part[9] = gets.chomp
  sub_header << "\tPrice: #{green(new_part[9])}\n"
  header_add_part(car,project,sub_header)
  puts "\nIs there a warranty? ('#{green("Y")}' / '#{red("N")}'')}'):"
  new_part[10] = gets.chomp
  new_part[10] = new_part[10].downcase == "y" ? true : false
  sub_header << "\tWarranty: #{green(new_part[10])}\n"
  header_add_part(car,project,sub_header)
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