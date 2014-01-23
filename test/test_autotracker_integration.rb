require 'test/unit'
require 'car'
require 'sqlite3'

class CommandInterfaceUnitTests < Test::Unit::TestCase

  def test_home_screen_command_exit
    shell_output = ""
    IO.popen('ruby autotracker.rb', 'r+') do |pipe|
      pipe.puts("5")
      pipe.close_write
      shell_output = pipe.read
    end
    expected_output = <<EOS
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
MAIN MENU > \e[32m1\e[0m(Show Cars) | \e[32m2\e[0m(Show Projects) | \e[32m3\e[0m(Add Car) | \e[32m4\e[0m(Add Project) | \e[31m5\e[0m(Exit)
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
\e[H\e[2J
EOS
    assert_equal expected_output, shell_output
  end

  def test_home_screen_command_show_cars
    db = SQLite3::Database.new "data/ruby_auto.sqlite"
    cars = Car.db_read(db)
    i = 1
    db_string = ""
    cars.each do |car|
      db_string << "\t#{i}. \e[33m#{car[1]} #{car[2]} #{car[3]}\e[0m\n"
      i += 1
    end
    shell_output = ""
    IO.popen('ruby autotracker.rb', 'r+') do |pipe|
      pipe.puts("1")
      pipe.puts("0")
      pipe.puts("5")
      pipe.close_write
      shell_output = pipe.read
    end
    expected_output = <<EOS
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
MAIN MENU > \e[32m1\e[0m(Show Cars) | \e[32m2\e[0m(Show Projects) | \e[32m3\e[0m(Add Car) | \e[32m4\e[0m(Add Project) | \e[31m5\e[0m(Exit)
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
CARS
#{db_string}
CARS MENU > \e[32m0\e[0m(Main Menu) | \e[32m1..3\e[0m(Select Car)
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
MAIN MENU > \e[32m1\e[0m(Show Cars) | \e[32m2\e[0m(Show Projects) | \e[32m3\e[0m(Add Car) | \e[32m4\e[0m(Add Project) | \e[31m5\e[0m(Exit)
\e[H\e[2J
\e[34mRUBY AUTO REPAIR TRACKER\e[0m
\e[34m========================\e[0m
\e[H\e[2J
EOS
    assert_equal expected_output, shell_output
  end
end