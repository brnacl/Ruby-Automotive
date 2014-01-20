def output_clear
  puts "\e[H\e[2J"
end

def output_header
  output_clear()
  puts purple("RUBY AUTO REPAIR TRACKER")
  puts purple("========================")
end