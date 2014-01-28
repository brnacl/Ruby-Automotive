require 'sqlite3'

require_relative 'lib/colors.rb'
require_relative 'lib/middleware.rb'

require_relative 'models/car.rb'
require_relative 'models/project.rb'

db = SQLite3::Database.new "db/ruby_auto.sqlite"

command_1 = ""
until command_1 == "0"
  cars = Car.find(db)
  output_header()
  output_main_menu(cars.length)
  output_all_cars(cars)
  command_1 = gets.chomp
  if command_1.to_i > 0
    current_car = cars[command_1.to_i - 1]
    command_2 = ""
    until command_2 == 0
      output_header()
      output_car_menu()
      output_car_details(current_car)
      command_2 = gets.to_i
      case command_2
      when 1
        output_header()
        current_info = output_car_update_value(current_car)
        if current_info
          command_3 = gets.to_i
          if command_3 == 1
            current_car.current_value = current_info[0]
            current_car.current_mileage = current_info[1]
            current_car.update(db)
          end
        end
      when 2
        projects = current_car.projects(db)
        command_3 = ""
        until command_3 == "0"
          output_header()
          output_car_projects(current_car,projects)
          command_3 = gets.chomp
          if command_3.to_i > 0
            current_project = projects[command_3.to_i - 1]
            command_4 = ""
            until command_4 == 0
              output_header()
              output_project_menu()
              output_project_details(current_car,current_project)
              command_4 = gets.to_i
              case command_4
              when 1
                parts = current_project.parts(db)
                command_5 = ""
                until command_5 == "0"
                  output_header()
                  output_project_parts(current_car,current_project,parts)
                  command_5 = gets.chomp
                  if command_5.to_i > 0
                    current_part = parts[command_5.to_i - 1]
                    command_6 = ""
                    until command_6 == 0
                      output_header()
                      output_part_menu()
                      output_part_details(current_car,current_project,current_part)
                      command_6 = gets.to_i
                      case command_6
                      when 1
                        if output_confirm_delete()
                          current_part.delete(db)
                          parts = current_project.parts(db)
                          command_6 = 0
                        end
                      end
                    end
                  elsif command_5 == "+"
                    output_header()
                    new_part = output_add_part(current_car,current_project)
                    if new_part
                      new_part.create(db)
                      parts = current_project.parts(db)
                    end
                  end


                end
              when 2
                if output_confirm_delete()
                  current_project.delete(db)
                  projects = current_car.projects(db)
                  command_4 = 0
                end
              end
            end
          elsif command_3 == "+"
            output_header()
            car_info_header = output_car_header(current_car)
            new_project = output_add_project(current_car,car_info_header)
            if new_project
              new_project.create(db)
              projects = current_car.projects(db)
            end
          end
        end
      when 3
        if output_confirm_delete()
          current_car.delete(db)
          command_2 = 0
        end
      end
    end
  elsif command_1 == "+"
    output_header()
    new_car = output_add_car()
    if new_car
      new_car.create(db)
      cars = Car.find(db)
    end
  end
end
output_clear()