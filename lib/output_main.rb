def clear_screen
  puts "\e[H\e[2J"
end

def header_main
  clear_screen()
  puts blue("RUBY AUTO REPAIR TRACKER")
  puts blue("========================")
end

def delete?
  puts red("\nDELETE:") + "Are you sure?"
  puts green("1")+"(Cancel) | "+ red("9")+"(DELETE)"
  confirm = gets.to_i
  return true if confirm == 9
  return false if confirm == 1
end


