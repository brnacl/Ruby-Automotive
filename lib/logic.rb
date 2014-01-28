def logic_main db,cars,command
  if command.to_i > 0
    car = cars[command.to_i - 1]
    logic_show_car(db,car)
  elsif command == "+"
    new_car = add_car()
    if new_car
      new_car.create(db)
      cars = Car.find(db)
    end
  end
end

def logic_show_car db,car
  command = ""
  until command == 0
    show_car(car)
    command = gets.to_i
    case command
    when 1
      logic_car_value(db,car)
    when 2
      projects = car.projects(db)
      logic_car_projects(db,car,projects)
    when 3
      if delete?
        car.delete(db)
        command = 0
      end
    end
  end
end

def logic_car_value db,car
  value = get_car_value(car)
  if value
    menu_car_value_save()
    command = gets.to_i
    if command == 1
      car.current_value = value[0]
      car.current_mileage = value[1]
      car.update(db)
    end
  end
end

def logic_car_projects db,car,projects
  command = ""
  until command == "0"
    show_projects(car,projects)
    command = gets.chomp
    if command.to_i > 0
      project = projects[command.to_i - 1]
      parts = project.parts(db)
      logic_show_project(db,car,project,parts)
    elsif command == "+"
      new_project = add_project(car)
      if new_project
        new_project.create(db)
        projects = car.projects(db)
      end
    end
  end
end

def logic_show_project db,car,project,parts
  command = ""
  until command == 0
    show_project(car,project,parts.length)
    command = gets.to_i
    case command
    when 1
      logic_project_parts(db,car,project,parts)
    when 2
      if delete?
        project.delete(db)
        projects = car.projects(db)
        command_4 = 0
      end
    end
  end
end

def logic_project_parts db,car,project,parts
  command = ""
  until command == "0"
    show_parts(car,project,parts)
    command = gets.chomp
    if command.to_i > 0
      part = parts[command_5.to_i - 1]
      logic_show_part(db,car,project,part)
    elsif command == "+"
      output_header()
      new_part = add_part(car,project)
      if new_part
        new_part.create(db)
        parts = project.parts(db)
      end
    end
  end
end

def logic_show_part db,car,project,part
  command = ""
  until command == 0
    show_part(car,project,part)
    command = gets.to_i
    case command
    when 1
      if delete?
        part.delete(db)
        parts = project.parts(db)
        command = 0
      end
    end
  end
end