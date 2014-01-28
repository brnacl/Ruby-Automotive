require 'test/unit'
require_relative '../models/car'

class CarUnitTests < Test::Unit::TestCase

  # DB = SQLite3::Database.new "db/ruby_auto.sqlite"

  # TESTCAR = Car.new({:car_id=>0,
  #                :year=>2006,
  #                :make=>"Volkswagen",
  #                :model=>"Jetta",
  #                :trim=>"2.5",
  #                :purchase_mileage=>105000,
  #                :purchase_price=>8500,
  #                :purchase_date=>"09/01/2012",
  #                :current_value=>0,
  #                :current_mileage=>0
  #               })

  # def test_car_year
  #   assert_equal(2006, TESTCAR.year)
  # end

  # def test_car_make
  #   assert_equal("Volkswagen", TESTCAR.make)
  # end

  # def test_car_model
  #   assert_equal("Jetta", TESTCAR.model)
  # end

  # def test_car_trim
  #   assert_equal("2.5", TESTCAR.trim)
  # end

  # def test_car_purchase_mileage
  #   assert_equal(105000, TESTCAR.purchase_mileage)
  # end

  # def test_car_purchase_price
  #   assert_equal(8500, TESTCAR.purchase_price)
  # end

  # def test_car_purchase_date
  #   assert_equal("09/01/2012", TESTCAR.purchase_date)
  # end

  # def test_car_current_value
  #   assert_equal(0, TESTCAR.current_value)
  # end

  # def test_car_current_mileage
  #   assert_equal(0, TESTCAR.current_mileage)
  # end

  # def test_car_get_current_value_returns_integer
  #   value = TESTCAR.get_current_value([120000,"Outstanding",37206])
  #   assert_operator(0, :<, value)
  # end

  # def test_car_attributes_returns_array_of_symbols
  #   attrs = Car.attributes
  #   assert_equal(attrs, [:car_id, :year, :make, :model, :trim, :purchase_mileage, :purchase_price, :purchase_date, :current_value, :current_mileage])
  # end

  # def test_car_projects_returns_array
  #   projects = TESTCAR.projects(DB)
  #   assert_kind_of(Array,projects)
  # end


end