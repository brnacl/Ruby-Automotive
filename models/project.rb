class Project
  attr_accessor :car_id, :title, :description, :mileage, :start_date
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    project = Project.new(attributes)
    project.save
    project
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    db = Environment.database_connection
    if id
      statement = "UPDATE Projects SET "
      statement << "CarID='#{car_id}', "
      statement << "Title='#{title}', "
      statement << "Description='#{description}', "
      statement << "Mileage='#{mileage}', "
      statement << "StartDate='#{start_date}' "
      statement << "WHERE ID='#{id}'"
      db.execute(statement)
    else
      statement = "INSERT INTO Projects "
      statement << "(CarID, Title, Description, Mileage, StartDate) "
      statement << "VALUES ('#{car_id}','#{title}','#{description}','#{mileage}','#{start_date}')"
      db.execute(statement)
      @id = db.last_insert_row_id
    end
  end

  def self.find id
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT * FROM Parts WHERE ID = #{id}"
    results = db.execute(statement)[0]
    if results
      project = Project.new(car_id: results["CarID"],
                            title: results["Title"],
                            description: results["Description"],
                            mileage: results["Mileage"],
                            start_date: results["StartDate"])
      project.send("id=", results["ID"])
      project
    else
      nil
    end
  end

  def self.search(search_term = nil)
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT Projects.* from Projects WHERE Title LIKE '%#{search_term}%' ORDER BY Title ASC"
    results = db.execute(statement)
    results.map do |row_hash|
      project = Project.new(car_id: row_hash["CarID"],
                            title: row_hash["Title"],
                            description: row_hash["Description"],
                            mileage: row_hash["Mileage"],
                            start_date: row_hash["StartDate"])
      project.send("id=", row_hash["ID"])
      project
    end
  end

  def delete
    db = Environment.database_connection
    begin
      statement = "DELETE FROM Projects WHERE ID='#{id}'; "
      statement << "DELETE FROM Parts WHERE ProjectID='#{id}'"
      db.execute(statement)
    rescue Exception=>e
      e
    end
  end

  def parts
    db = Environment.database_connection
    output = []
    begin
      statement = "SELECT * FROM Parts p "
      statement << "INNER JOIN Projects proj ON proj.ID = p.ProjectID "
      statement << "WHERE proj.ID = '#{id}'"
      results = db.execute(statement)
      results.map do |row_hash|
        part = Part.new(car_id: row_hash["CarID"],
                        project_id: row_hash["ProjectID"],
                        name: row_hash["Name"],
                        replacement_date: row_hash["ReplacementDate"],
                        description: row_hash["Description"],
                        manufacturer: row_hash["Manufacturer"],
                        model_num: row_hash["ModelNumber"],
                        vendor: row_hash["Vendor"],
                        purchase_price: row_hash["PurchasePrice"],
                        warranty: row_hash["Warranty"])
        part.send("id=", row_hash["ID"])
        part
      end
    rescue Exception=>e
      e
    end
  end

  def self.all
    search
  end

  def to_s
    "#{title}, #{mileage} miles, #{start_date}"
  end

  def == (other)
    if self.to_s == other.to_s
      true
    else
      false
    end
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:car_id, :title, :description, :mileage, :start_date].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
