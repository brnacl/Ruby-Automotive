require_relative 'lib/car.rb'

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def black(text); colorize(text, 30); end
def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def yellow(text); colorize(text, 33); end
def blue(text); colorize(text, 34); end
def purple(text); colorize(text, 35); end
def cyan(text); colorize(text, 36); end
def white(text); colorize(text, 37); end

puts "\e[H\e[2J"
puts green("RUBY AUTO REPAIR TRACKER")
puts green("========================")

if ARGV[0].nil?
  command = ""
else
  command = ARGV[0]
end

until command.downcase == "exit"
  puts yellow("Please Enter a Command:") + blue("(add_car, add_project, add_part, show_cars, show_projects, show_parts, exit)")
  command = gets.chomp.downcase
  puts "\e[H\e[2J"
  puts green("RUBY AUTO REPAIR TRACKER")
  puts green("========================")
  case command
  when 'add_car'
    puts purple("...Adding Car")
  when 'add_project'
    puts purple("...Adding Project")
  when 'add_part'
    puts purple("...Adding Part")
  when 'show_cars'
    puts purple("...Showing Cars")
  when 'show_projects'
    puts purple("...Showing Projects")
  when 'show_parts'
    puts purple("...Showing Parts")
  when 'exit'
    puts "\e[H\e[2J"
    break
  else
    puts red("Error: Invalid Command!") if command.downcase != "exit"
  end
end