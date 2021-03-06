require_relative 'helper'

class TestProject < AutoTest

  def test_car_id
    project = Project.new(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    assert_equal(1, project.car_id)
  end

  def test_title
    project = Project.new(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    assert_equal("Fix the car", project.title)
  end

  def test_description
    project = Project.new(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    assert_equal("A nice happy little test project", project.description)
  end

  def test_mileage
    project = Project.new(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    assert_equal(150000, project.mileage)
  end

  def test_formatted_start_date
    project = Project.new(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    assert_equal("2014-01-01", project.formatted_start_date)
  end

  def test_parts_returns_array
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    Part.create(car_id: 1, project_id: project.id, name: "Engine Bolt", replacement_date: "01/01/2014", description: "A happy little engine bolt", manufacturer: "Bolt, Co.", model_number: "ABC-123-XYZ", vendor: "Auto Zone", purchase_price: 5.00, warranty: true)
    parts = project.parts
    assert_equal(1,parts.length)
  end

  def test_all_returns_array
    Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    Project.create(car_id: 1, title: "Fix the engine", description: "Engine make car go", mileage: 150000, start_date: "01/01/2014")
    num_projects = Project.count
    assert_equal(2,num_projects)
  end

  def test_update_doesnt_insert_new_row
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    foos_before = Project.count
    project.update(mileage: 155000)
    foos_after = Project.count
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    id = project.id
    project.update(mileage: 155000)
    updated_project = Project.find(id)
    expected = [1, "Fix the car", "A nice happy little test project", 155000]
    actual = [updated_project.car_id, updated_project.title, updated_project.description, updated_project.mileage]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    project.update(mileage: 155000)
    expected = [1, "Fix the car", "A nice happy little test project", 155000]
    actual = [project.car_id, project.title, project.description, project.mileage]
    assert_equal expected, actual
  end

  def test_saved_projects_are_saved
    project = Project.new(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    foos_before = Project.count
    project.save
    foos_after = Project.count
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    refute_nil project.id, "Project id shouldn't be nil"
  end

  def test_find_returns_the_row_as_project_object
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    found = Project.find(project.id)
    assert_equal project, found
  end

  def test_search_returns_project_objects
    Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    Project.create(car_id: 1, title: "Fix the engine", description: "Engine make car go", mileage: 150000, start_date: "01/01/2014")
    Project.create(car_id: 1, title: "Fix the tranny", description: "Not that kind of tranny!", mileage: 150000, start_date: "01/01/2014")
    results = Project.search("Fix")
    assert results.all?{ |result| result.is_a? Project }, "Not all results were Projects"
  end

  def test_search_returns_empty_array_if_no_results
    Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    Project.create(car_id: 1, title: "Fix the engine", description: "Engine make car go", mileage: 150000, start_date: "01/01/2014")
    Project.create(car_id: 1, title: "Fix the tranny", description: "Not that kind of tranny!", mileage: 150000, start_date: "01/01/2014")
    results = Project.search("tire")
    assert_equal [], results
  end

  def test_all_returns_all_projects_in_alphabetical_order
    Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    Project.create(car_id: 1, title: "Fix the engine", description: "Engine make car go", mileage: 150000, start_date: "01/01/2014")
    results = Project.all
    expected = [ "Fix the car","Fix the engine"]
    actual = results.map{ |project| project.title }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_projects
    results = Project.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    assert project == project
  end

  def test_equality_with_different_class
    project = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    refute project == "Project"
  end

  def test_equality_with_different_project
    project1 = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    project2 = Project.create(car_id: 1, title: "Fix the engine", description: "Engine make car go", mileage: 150000, start_date: "01/01/2014")
    refute project1 == project2
  end

  def test_equality_with_same_project_different_object_id
    project1 = Project.create(car_id: 1, title: "Fix the car", description: "A nice happy little test project", mileage: 150000, start_date: "01/01/2014")
    project2 = Project.find(project1.id)
    assert project1 == project2
  end

end