require 'sqlite3'

require_relative 'lib/colors.rb'
require_relative 'lib/middleware.rb'

require_relative 'lib/car.rb'
require_relative 'lib/project.rb'

db = SQLite3::Database.new "data/ruby_auto.sqlite"

command_1 = ARGV[0].nil? ? nil : ARGV[0]

output_header()

until command_1.to_i == 5
  output_header()
  output_main_menu()
  command_1 = gets.to_i
  output_header()

  case command_1
  when 1
    cars = Car.db_read(db)
    output_all_cars_menu(cars.length)
    ids = output_all_cars(cars)
    command_2 = gets.to_i
    car_id = ids[command_2.to_i]
    if command_2.to_i > 0
      command_3 = ""
      until command_3 == 0
        output_header()
        output_car_menu()
        current_car = Car.db_read(db,car_id)[0]
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
              current_car.db_update(db,current_car.car_id)
            end
          end
        when 2
          confirm_delete = output_car_confirm_delete()
          if confirm_delete
            current_car.db_delete(db,current_car.car_id)
            command_3 = 0
          end
        end
      end
      output_header()
    end

  when 2
    ids = output_all_projects(db)
    output_all_projects_menu(ids.length-1)
    command_2 = gets.to_i
  when 3
    output_add_car(db)
  when 4
    ids = output_add_project_cars(db)
    output_all_cars_menu(ids.length-1)

    selection = gets.to_i
    if selection > 0 && selection < ids.length
      output_header()
      car_id = ids[selection]
      header = output_add_project_car_header(db, car_id)
      output_add_project(db,car_id,header)
    end
  when 5
    output_clear()
    break
  else
    puts red("Error: Invalid Command!")
  end
end