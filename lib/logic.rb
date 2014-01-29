class Logic
  attr_accessor :cars,:projects,:parts

  def initialize attributes={}
    [:cars,:projects,:parts].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def logic_main command
    if command.to_i > 0
      car = cars[command.to_i - 1]
      logic_show_car(car)
    elsif command == "+"
      new_car = add_car
      if new_car
        new_car.save
        cars = Car.all
      end
    end
  end

  def logic_show_car car
    command = ""
    until command == 0
      show_car(car)
      command = gets.to_i
      case command
      when 1
        logic_car_value(car)
      when 2
        @projects = car.projects
        logic_car_projects(car)
      when 3
        if delete?
          car.delete
          command = 0
        end
      end
    end
  end

  def logic_car_value car
    value = get_car_value(car)
    if value
      menu_car_value_save
      command = gets.to_i
      if command == 1
        car.update(current_value: value[0], current_mileage: value[1])
        car.save
      end
    end
  end

  def logic_car_projects car
    command = ""
    until command == "0"
      show_projects(car,@projects)
      command = gets.chomp
      if command.to_i > 0
        project = @projects[command.to_i - 1]
        @parts = project.parts
        logic_show_project(car,project)
      elsif command == "+"
        new_project = add_project(car)
        if new_project
          new_project.save
          @projects = car.projects
        end
      end
    end
  end

  def logic_show_project car,project
    command = ""
    until command == 0
      show_project(car,project,@parts.length)
      command = gets.to_i
      case command
      when 1
        logic_project_parts(car,project)
      when 2
        if delete?
          project.delete
          @projects = car.projects
          command = 0
        end
      end
    end
  end

  def logic_project_parts car,project
    command = ""
    until command == "0"
      show_parts(car,project,@parts)
      command = gets.chomp
      if command.to_i > 0
        part = @parts[command.to_i - 1]
        logic_show_part(car,project,part)
      elsif command == "+"
        header_main
        new_part = add_part(car,project)
        if new_part
          new_part.save
          @parts = project.parts
        end
      end
    end
  end

  def logic_show_part car,project,part
    command = ""
    until command == 0
      show_part(car,project,part)
      command = gets.to_i
      case command
      when 1
        if delete?
          part.delete
          @parts = project.parts
          command = 0
        end
      end
    end
  end
end