def output_clear
  puts "\e[H\e[2J"
end

def output_header
  output_clear()
  puts green("RUBY AUTO REPAIR TRACKER")
  puts green("========================")
end