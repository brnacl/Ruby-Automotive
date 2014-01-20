require 'test/unit'
require 'car'

class CommandInterfaceUnitTests < Test::Unit::TestCase

  def test_car_class_year
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal(2006, car.year)
  end

  def test_car_class_make
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal("Volkswagen", car.make)
  end

  def test_car_class_model
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal("Jetta", car.model)
  end

  def test_car_class_trim
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal("2.5", car.trim)
  end

  def test_car_class_purchase_mileage
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal(105000, car.purchase_mileage)
  end

  def test_car_class_purchase_price
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal(8500, car.purchase_price)
  end

  def test_car_class_purchase_date
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    assert_equal("09/01/2012", car.purchase_date)
  end

  def test_car_class_current_value_1
    car = Car.new(2006, 'Volkswagen', 'Jetta', '2.5', 105000, 8500, '09/01/2012')
    current_value = car.current_value(120000, "Outstanding", 37206)
    assert_operator(0, :<, current_value)
  end

  def test_car_class_current_value_2
    car = Car.new(2000, 'Honda', 'Accord', 'EX', 200000, 5000, '02/16/2013')
    current_value = car.current_value(230000, "Clean", 37215)
    assert_operator(0, :<, current_value)
  end

end