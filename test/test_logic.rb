# require_relative 'helper'
# require_relative '../lib/logic'
# require_relative '../models/car'
# require_relative '../models/project'
# require_relative '../models/part'

# class TestLogic < AutoTest

#   def test_logic_main_add_car
#     cars = Car.all
#     mock = MiniTest::Mock.new

#     # mock expects:
#     #            method      return  arguments
#     #-------------------------------------------------------------
#     mock.expect(:logic_show_car,  nil, [])

#     logic = Logic.new(mock)
#     logic.cars = cars
#     logic.logic_main(1)

#     assert mock.verify

#   end

# end