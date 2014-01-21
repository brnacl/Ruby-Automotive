def output_clear
  puts "\e[H\e[2J"
end

def output_header
  output_clear()
  puts blue("RUBY AUTO REPAIR TRACKER")
  puts blue("========================")
end

def output_main_menu
  menu = "MAIN MENU > "
  menu << green("1")+"(Show Cars) | "
  menu << green("2")+"(Show Projects) | "
  menu << green("3")+"(Add Car) | "
  menu << green("4")+"(Add Project) | "
  menu << red("5")+"(Exit)"
  puts menu
end

def output_car_menu
  menu = "\nCAR MENU > "
  menu << green("0")+"(Main Menu) | "
  menu << green("1")+"(Update Current Value) | "
  menu << red("2")+"(Delete Car)"
  puts menu
end

def output_car_menu_update_value
  menu = "\nUPDATE MENU > "
  menu << green("1")+"(Update Current Value) | "
  menu << red("2")+"(Cancel Update)"
  puts menu
end

def output_car_details details
  output = ">> "+yellow("#{details[1]} #{details[2]} #{details[3]}\n\n")
  output << "\tTrim Package:\t\t"+yellow(details[4])+"\n"
  output << "\tPurchase Mileage:\t"+yellow(details[5].to_s)+"\n"
  output << "\tPurchase Price:\t\t"+yellow("$"+details[6].to_s)+"\n"
  output << "\tPurchase Date:\t\t"+yellow(details[7])+"\n"
  output << "\tCurrent Mileage:\t"+yellow(details[9].to_s)+"\n"
  output << "\tCurrent Value:\t\t"+yellow("$"+details[8].to_s)+"\n"
  puts output
end