require 'sqlite3'

require_relative 'lib/colors.rb'
require_relative 'lib/middleware.rb'

require_relative 'models/car.rb'
require_relative 'models/project.rb'

db = SQLite3::Database.new "db/ruby_auto.sqlite"

command_1 = ARGV[0].nil? ? nil : ARGV[0]

output_header()

until command_1.to_i == 5
  output_header()
  output_main_menu()
  command_1 = gets.to_i
  output_header()

  case command_1
  when 1
    cars = Car.find(db)
    output_all_cars_menu(cars.length)
    output_all_cars(cars)
    command_2 = gets.to_i
    if command_2 > 0
      current_car = cars[command_2 - 1]
      command_3 = ""
      until command_3 == 0
        output_header()
        output_car_menu()
        output_car_details(current_car)
        command_3 = gets.to_i
        case command_3
        when 1
          output_header()
          current_info = output_car_update_value(current_car)
          if current_info
            command_4 = gets.to_i
            if command_4 == 1
              current_car.current_value = current_info[0]
              current_car.current_mileage = current_info[1]
              current_car.update(db)
            end
          end
        when 2
          if output_confirm_delete()
            current_car.delete(db)
            command_3 = 0
          end
        end
      end
      output_header()
    end

  when 2
    cars = Car.find(db)
    output_all_projects_cars_menu(cars.length)
    output_all_cars(cars)
    command_2 = gets.to_i
    if command_2 > 0
      current_car = cars[command_2 - 1]
      projects = current_car.projects(db)
      command_3 = ""
      until command_3 == 0
        output_header()
        output_car_projects_menu(projects.length)
        output_car_projects(current_car,projects)
        command_3 = gets.to_i
        if command_3 > 0
          current_project = projects[command_3 - 1]
          command_4 = ""
          until command_4 == 0
            output_header()
            output_project_menu()
            output_project_details(current_car,current_project)
            command_4 = gets.to_i
            case command_4
            when 1
              puts "Showing Parts"
            when 2
              if output_confirm_delete()
                current_project.delete(db)
                projects = current_car.projects(db)
                command_4 = 0
              end
            end
          end
        end
      end
      output_header()
    end
  when 3
    output_add_car(db)
  when 4
    ids = output_add_project_cars(db)
    output_all_cars_menu(ids.length-1)

    selection = gets.to_i
    if selection > 0 && selection < ids.length
      output_header()
      car_id = ids[selection]
      header = output_car_header(car)
      output_add_project(car,header)
    end
  when 5
    output_clear()
    break
  else
    puts red("Error: Invalid Command!")
  end
end