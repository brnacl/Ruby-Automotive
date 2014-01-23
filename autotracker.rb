require 'sqlite3'

require_relative 'lib/colors.rb'
require_relative 'lib/middleware.rb'

require_relative 'lib/car.rb'

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
    ids = output_all_cars(db)
    output_all_cars_menu(ids.length-1)

    command_2 = gets.to_i
    if command_2.to_i > 0
      command_3 = ""
      until command_3 == 0
        output_header()
        details = Car.db_read(db,ids[command_2.to_i])[0]
        current_car = Car.new(details)
        output_car_details(details)
        output_car_menu()

        command_3 = gets.to_i
        case command_3
        when 1
          output_header()
          output_car_details(details)
          current_info = output_car_update_value(current_car)
          if current_info

            command_4 = gets.to_i
            if command_4 == 1
              current_car.current_value = current_info[0]
              current_car.current_mileage = current_info[1]
              current_car.db_update(db,ids[command_2.to_i])
            end
          end
        when 2
          confirm_delete = output_car_confirm_delete()
          if confirm_delete
            current_car.db_delete(db,ids[command_2.to_i])
            command_3 = 0
          end
        end
      end
      output_header()
    end

  when 2
    puts purple("...Showing Projects\n")
  when 3
    output_add_car(db)
  when 4
    puts purple("...Adding Projects\n")
  when 5
    output_clear()
    break
  else
    puts red("Error: Invalid Command!")
  end
end