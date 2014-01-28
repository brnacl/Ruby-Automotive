def header_project project
  puts "\nPROJECT: " + green("#{project.title}, #{project.start_date}, #{project.mileage}")
end

def header_add_project car,sub_header
  header_main()
  menu_add_project()
  header_car(car)
  puts sub_header
end

def menu_projects num_projects
  menu = "\nPROJECTS MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1..#{num_projects}")+"(Select Project) " if num_projects > 0
  menu << green("+") + "(Add Project)"
  puts menu
end

def menu_project
  menu = "\nPROJECT MENU > "
  menu << green("0")+"(Main Menu) "
  menu << green("1")+"(Show Project Parts) "
  menu << red("2")+"(Delete Project)"
  puts menu
end

def menu_add_project
  menu = "\nADD PROJECT > "
  menu << red("0")+"(Cancel)\n\n"
  puts menu
end


def show_projects car, projects
  header_main()
  menu_projects(projects.length)
  header_car(car)
  if projects.length > 0
    puts "\nPROJECTS:\n"
    i = 1
    projects.each do |project|
      puts "\t#{i}. "+yellow("#{project.title} #{project.start_date}")
      i += 1
    end
  else
    puts red("NO PROJECTS")
  end
end

def show_project car,project,num_parts
  header_main()
  menu_project()
  header_car(car)
  header_project(project)
  details = "\n\tDescription:\t#{yellow(project.description)}\n"
  details << "\n\tTotal Parts:\t#{yellow(num_parts)}\n"
  puts details
end

def add_project car
  sub_header = ""
  header_add_project(car,sub_header)
  new_project = []
  new_project[0] = 0
  new_project[1] = car.car_id
  puts "\nEnter a title for this new project..."
  new_project[2] = gets.chomp
  return false if new_project[2] == "0"
  sub_header << "\tProject: #{green(new_project[2])}\n"
  header_add_project(car,sub_header)
  puts "\nEnter a description:"
  new_project[3] = gets.chomp
  return false if new_project[3] == "0"
  sub_header << "\tDescription: #{green(new_project[3])}\n"
  header_add_project(car,sub_header)
  puts "\nEnter vehicle mileage..."
  new_project[4] = gets.chomp
  return false if new_project[4] == "0"
  sub_header << "\tMileage: #{green(new_project[4])}\n"
  header_add_project(car,sub_header)
  puts "\nEnter the start date for the project..."
  new_project[5] = gets.chomp
  return false if new_project[5] == "0"
  sub_header << "\tStart Date: #{green(new_project[5])}\n"
  header_add_project(car,sub_header)
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
  new_project
end