require 'sqlite3'

require_relative 'lib/colors.rb'
require_relative 'lib/output_main.rb'
require_relative 'lib/output_car.rb'
require_relative 'lib/output_project.rb'
require_relative 'lib/output_part.rb'
require_relative 'models/car.rb'
require_relative 'models/project.rb'
require_relative 'models/part.rb'

db = SQLite3::Database.new "db/ruby_auto.sqlite"

command_1 = ""
until command_1 == "0"
  cars = Car.find(db)
  show_cars(cars)
  command_1 = gets.chomp
  if command_1.to_i > 0
    car = cars[command_1.to_i - 1]
    command_2 = ""
    until command_2 == 0
      show_car(car)
      command_2 = gets.to_i
      case command_2
      when 1
        value = get_car_value(car)
        if value
          menu_car_value_save()
          command_3 = gets.to_i
          if command_3 == 1
            car.current_value = value[0]
            car.current_mileage = value[1]
            car.update(db)
          end
        end
      when 2
        projects = car.projects(db)
        command_3 = ""
        until command_3 == "0"
          show_projects(car,projects)
          command_3 = gets.chomp
          if command_3.to_i > 0
            project = projects[command_3.to_i - 1]
            parts = project.parts(db)
            command_4 = ""
            until command_4 == 0
              show_project(car,project,parts.length)
              command_4 = gets.to_i
              case command_4
              when 1
                parts = project.parts(db)
                command_5 = ""
                until command_5 == "0"
                  show_parts(car,project,parts)
                  command_5 = gets.chomp
                  if command_5.to_i > 0
                    part = parts[command_5.to_i - 1]
                    command_6 = ""
                    until command_6 == 0
                      show_part(car,project,part)
                      command_6 = gets.to_i
                      case command_6
                      when 1
                        if delete?
                          part.delete(db)
                          parts = project.parts(db)
                          command_6 = 0
                        end
                      end
                    end
                  elsif command_5 == "+"
                    output_header()
                    new_part = add_part(car,project)
                    if new_part
                      new_part.create(db)
                      parts = project.parts(db)
                    end
                  end
                end
              when 2
                if delete?
                  project.delete(db)
                  projects = car.projects(db)
                  command_4 = 0
                end
              end
            end
          elsif command_3 == "+"
            new_project = add_project(car)
            if new_project
              new_project.create(db)
              projects = car.projects(db)
            end
          end
        end
      when 3
        if delete?
          car.delete(db)
          command_2 = 0
        end
      end
    end
  elsif command_1 == "+"
    new_car = add_car()
    if new_car
      new_car.create(db)
      cars = Car.find(db)
    end
  end
end
output_clear()