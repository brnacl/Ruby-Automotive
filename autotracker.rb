require_relative 'lib/colors.rb'
require_relative 'lib/output_formatting.rb'
require_relative 'lib/mechanics.rb'
require_relative 'lib/db.rb'

require_relative 'lib/car.rb'

db = DB.new

command_1 = ARGV[0].nil? ? nil : ARGV[0]

output_header()

until command_1.to_i == 5
  output_header()
  output_main_menu()
  command_1 = gets.to_i
  output_header()

  case command_1
  when 1
    ids = get_cars(db)
    puts "\nPlease Enter a #{red('NUMBER')} to display vehicle information, or "+green("0")+" for main menu..."
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
          puts "\nPlease Enter current mileage:"
          current_mileage = gets.to_i
          puts "\nPlease Enter current condition:"
          condition = gets.chomp
          puts "\nPlease Enter current zip-code:"
          zip_code = gets.to_i
          puts "Getting current value..."
          current_value = current_car.get_current_value(current_mileage,condition,zip_code)
          puts "Current value: "+blue("$#{current_value}")
          puts "\nPlease Enter a #{red('NUMBER')}..."
          output_car_menu_update_value()
          command_4 = gets.to_i
          if command_4 == 1
            current_car.current_value = current_value
            current_car.current_mileage = current_mileage
            current_car.db_update(db,ids[command_2.to_i])
          end
        when 2

        end
      end
      output_header()
    end

  when 2
    puts purple("...Showing Projects\n")
  when 3
    add_car(db)
  when 4
    puts purple("...Adding Projects\n")
  when 5
    output_clear()
    break
  else
    puts red("Error: Invalid Command!")
  end
end