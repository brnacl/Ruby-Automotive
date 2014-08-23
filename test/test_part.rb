require_relative 'helper'

class TestPart < AutoTest

  def test_car_id
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal(1, part.car_id)
  end

  def test_project_id
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal(1, part.project_id)
  end

  def test_name
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("Engine Bolt", part.name)
  end

  def test_formatted_replacement_date
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("2014-01-01", part.formatted_replacement_date)
  end

  def test_description
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("A happy little engine bolt", part.description)
  end

  def test_manufacturer
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("Bolt, Co.", part.manufacturer)
  end

  def test_model_number
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("ABC-123-XYZ", part.model_number)
  end

  def test_vendor
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("Auto Zone", part.vendor)
  end

  def test_formatted_purchase_price
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal("$5.00", part.formatted_purchase_price)
  end

  def test_warranty
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal(true, part.warranty)
  end

  def test_all_returns_array
    Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    Part.create(car_id: 1, project_id: 1, name: "Wheel Nut", replacement_date: "01/01/2014", description: "A happy little wheel nut", manufacturer: "Nut, Co.", model_number: "ABC-456-XYZ", vendor: "Auto Zone", purchase_price: 2.00, warranty: false)
    Part.create(car_id: 1, project_id: 1, name: "Seat Screw", replacement_date: "01/01/2014", description: "A happy little seat screw", manufacturer: "Screw, Co.", model_number: "ABC-789-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert_equal(3,Part.count)
  end

  def test_update_doesnt_insert_new_row
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    foos_before = Part.count
    part.update(warranty: false)
    foos_after = Part.count
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    id = part.id
    part.update(warranty: "false")
    updated_part = Part.find(id)
    expected = [1, 1, "Engine Bolt", "A happy little engine bolt", false]
    actual = [updated_part.car_id, updated_part.project_id, updated_part.name, updated_part.description, updated_part.warranty]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    part.update(warranty: "false")
    expected = [1, 1, "Engine Bolt", "A happy little engine bolt", false]
    actual = [part.car_id, part.project_id, part.name, part.description, part.warranty]
    assert_equal expected, actual
  end

  def test_saved_parts_are_saved
    part = Part.new(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    foos_before = Part.count
    part.save
    foos_after = Part.count
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    refute_nil part.id, "Part id shouldn't be nil"
  end

  def test_find_returns_the_row_as_part_object
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    found = Part.find(part.id)
    assert_equal part, found
  end

  def test_search_returns_part_objects
    Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    Part.create(car_id: 1, project_id: 1, name: "Wheel Nut", replacement_date: "01/01/2014", description: "A happy little wheel nut", manufacturer: "Nut, Co.", model_number: "ABC-456-XYZ", vendor: "Auto Zone", purchase_price: 2.00, warranty: false)
    Part.create(car_id: 1, project_id: 1, name: "Seat Screw", replacement_date: "01/01/2014", description: "A happy little seat screw", manufacturer: "Screw, Co.", model_number: "ABC-789-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    results = Part.search("Screw")
    assert results.all?{ |result| result.is_a? Part }, "Not all results were Parts"
  end

  def test_search_returns_empty_array_if_no_results
    Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    Part.create(car_id: 1, project_id: 1, name: "Wheel Nut", replacement_date: "01/01/2014", description: "A happy little wheel nut", manufacturer: "Nut, Co.", model_number: "ABC-456-XYZ", vendor: "Auto Zone", purchase_price: 2.00, warranty: false)
    Part.create(car_id: 1, project_id: 1, name: "Seat Screw", replacement_date: "01/01/2014", description: "A happy little seat screw", manufacturer: "Screw, Co.", model_number: "ABC-789-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    results = Part.search("tire")
    assert_equal [], results
  end

  def test_all_returns_all_parts_in_alphabetical_order
    Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    Part.create(car_id: 1, project_id: 1, name: "Wheel Nut", replacement_date: "01/01/2014", description: "A happy little wheel nut", manufacturer: "Nut, Co.", model_number: "ABC-456-XYZ", vendor: "Auto Zone", purchase_price: 2.00, warranty: false)
    results = Part.all
    expected = ["Engine Bolt","Wheel Nut"]
    actual = results.map{ |part| part.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_parts
    results = Part.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    assert part == part
  end

  def test_equality_with_different_class
    part = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    refute part == "Part"
  end

  def test_equality_with_different_part
    part1 = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    part2 = Part.create(car_id: 1, project_id: 1, name: "Wheel Nut", replacement_date: "01/01/2014", description: "A happy little wheel nut", manufacturer: "Nut, Co.", model_number: "ABC-456-XYZ", vendor: "Auto Zone", purchase_price: 2.00, warranty: false)
    refute part1 == part2
  end

  def test_equality_with_same_part_different_object_id
    part1 = Part.create(car_id: 1, project_id: 1, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    part2 = Part.find(part1.id)
    assert part1 == part2
  end

end