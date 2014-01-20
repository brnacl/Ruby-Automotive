require 'test/unit'
require 'car'

class CommandInterfaceUnitTests < Test::Unit::TestCase

  def test_command_interface_header
    expected_output = <<EOS
\e[H\e[2J\nRUBY AUTO REPAIR TRACKER
========================
EOS
    assert_equal(expected_output, `ruby autotracker.rb exit`)
  end

end