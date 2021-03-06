require_relative 'helper'

class TestCar < AutoTest

  def test_count_when_no_cars
    assert_equal 0, Car.count
  end

  def test_count_of_multiple_cars
    Car.create(year: 2006, make: "Volkswagen", model: "Jetta", trim: "2.5", purchase_mileage: 105000, purchase_price: 8500, purchase_date: "09/01/2012")
    Car.create(year: 2000, make: "Honda", model: "Civic", trim: "LX", purchase_mileage: 150000, purchase_price: 3500, purchase_date: "01/01/2013")
    Car.create(year: 2004, make: "Audi", model: "A4", trim: "Quattro", purchase_mileage: 85000, purchase_price: 25000, purchase_date: "01/10/2009")
    assert_equal 3, Car.count
  end

  def test_car_year
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal(2006, car.year)
  end

  def test_car_make
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal("Volkswagen", car.make)
  end

  def test_car_model
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal("Jetta", car.model)
  end

  def test_car_trim
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal("2.5", car.trim)
  end

  def test_car_purchase_mileage
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal(105000, car.purchase_mileage)
  end

  def test_car_formatted_purchase_price
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal("$8500.00", car.formatted_purchase_price)
  end

  def test_car_formatted_purchase_date_saves_date_data_type
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert_equal("2012-01-09", car.formatted_purchase_date)
  end

  # def test_car_current_value_initializes_to_purchase_price
  #   car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
  #   assert_equal(car.purchase_price, car.current_value)
  # end

  # def test_car_current_mileage_initializes_to_purchase_mileage
  #   car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
  #   assert_equal(car.purchase_mileage, car.current_mileage)
  # end


  def test_car_projects_returns_array
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    Project.create(car_id: car.id, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    projects = car.projects
    assert_equal(1,projects.length)
  end

  def test_car_all_returns_array
    Car.create(year: 2006, make: "Volkswagen", model: "Jetta", trim: "2.5", purchase_mileage: 105000, purchase_price: 8500, purchase_date: "09/01/2012")
    Car.create(year: 2000, make: "Honda", model: "Civic", trim: "LX", purchase_mileage: 150000, purchase_price: 3500, purchase_date: "01/01/2013")
    Car.create(year: 2004, make: "Audi", model: "A4", trim: "Quattro", purchase_mileage: 85000, purchase_price: 25000, purchase_date: "01/10/2009")
    num_cars = Car.count
    assert_equal(3,num_cars)
  end

  def test_update_doesnt_insert_new_row
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    foos_before = Car.count
    car.update(trim: "2.0")
    foos_after = Car.count
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    id = car.id
    car.update(trim: "2.0")
    updated_car = Car.find(id)
    expected = [2006, "Volkswagen", "Jetta", "2.0" ]
    actual = [updated_car.year, updated_car.make, updated_car.model, updated_car.trim]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    car.update(trim: "2.0")
    expected = [2006, "Volkswagen", "Jetta", "2.0" ]
    actual = [car.year, car.make, car.model, car.trim]
    assert_equal expected, actual
  end

  def test_saved_cars_are_saved
    car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    foos_before = Car.count
    car.save
    foos_after = Car.count
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    refute_nil car.id, "Car id shouldn't be nil"
  end

  def test_find_returns_the_row_as_car_object
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    found = Car.find(car.id)
    assert_equal car, found
  end

  def test_search_returns_car_objects
    Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    Car.create(year: 2012,make: "Audi",model: "S4",trim: "quattro",purchase_mileage: 1000,purchase_price: 40000,purchase_date: "01/01/2013")
    Car.create(year: 2004,make: "Honda",model: "Accord",trim: "LX",purchase_mileage: 140000,purchase_price: 5500,purchase_date: "10/29/2013")
    results = Car.search("Audi")
    assert results.all?{ |result| result.is_a? Car }, "Not all results were Cars"
  end

  def test_search_returns_empty_array_if_no_results
    Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    Car.create(year: 2012,make: "Audi",model: "S4",trim: "quattro",purchase_mileage: 1000,purchase_price: 40000,purchase_date: "01/01/2013")
    Car.create(year: 2004,make: "Honda",model: "Accord",trim: "LX",purchase_mileage: 140000,purchase_price: 5500,purchase_date: "10/29/2013")
    results = Car.search("BMW")
    assert_equal [], results
  end

  def test_all_returns_all_cars_in_alphabetical_order
    Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    Car.create(year: 2012,make: "Audi",model: "S4",trim: "quattro",purchase_mileage: 1000,purchase_price: 40000,purchase_date: "01/01/2013")
    results = Car.all
    expected = [ "Audi","Volkswagen"]
    actual = results.map{ |car| car.make }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_cars
    results = Car.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    assert car == car
  end

  def test_equality_with_different_class
    car = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    refute car == "Car"
  end

  def test_equality_with_different_car
    car1 = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    car2 = Car.create(year: 2012,make: "Audi",model: "S4",trim: "quattro",purchase_mileage: 1000,purchase_price: 40000,purchase_date: "01/01/2013")
    refute car1 == car2
  end

  def test_equality_with_same_car_different_object_id
    car1 = Car.create(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
    car2 = Car.find(car1.id)
    assert car1 == car2
  end

  def test_find_returns_the_row_as_car_object
    car = Car.create(year: 2006, make: "Volkswagen", model: "Jetta", trim: "2.5", purchase_mileage: 105000, purchase_price: 8500, purchase_date: "09/01/2012")
    found = Car.find(car.id)
    assert_equal car.year, found.year
    assert_equal car.make, found.make
    assert_equal car.model, found.model
    assert_equal car.projects, found.projects
  end

  # def test_car_get_current_value_returns_integer
  #   car = Car.new(year: 2006,make: "Volkswagen",model: "Jetta",trim: "2.5",purchase_mileage: 105000,purchase_price: 8500,purchase_date: "09/01/2012")
  #   value = car.get_current_value([120000,"Outstanding",37206])
  #   assert_operator(0, :<, value)
  # end

end