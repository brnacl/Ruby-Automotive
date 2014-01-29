class Part
  attr_accessor :car_id, :project_id, :name, :replacement_date, :description, :manufacturer, :model_num, :vendor, :purchase_price, :warranty
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    part = Part.new(attributes)
    part.save
    part
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    db = Environment.database_connection
    if id
      statement = "UPDATE Parts SET "
      statement << "CarID='#{car_id}', "
      statement << "ProjectID='#{project_id}', "
      statement << "Name='#{name}', "
      statement << "ReplacementDate='#{replacement_date}', "
      statement << "Description='#{description}', "
      statement << "Manufacturer='#{manufacturer}', "
      statement << "ModelNumber='#{model_num}', "
      statement << "Vendor='#{vendor}', "
      statement << "PurchasePrice='#{purchase_price}', "
      statement << "Warranty='#{warranty}' "
      statement << "WHERE ID='#{id}'"
      db.execute(statement)
    else
      statement = "INSERT INTO Parts "
      statement << "(CarID,ProjectID,Name,ReplacementDate,Description,Manufacturer,ModelNumber,Vendor,PurchasePrice,Warranty) "
      statement << "VALUES ('#{car_id}', '#{project_id}', '#{name}', '#{replacement_date}', '#{description}', '#{manufacturer}', '#{model_num}', '#{vendor}', '#{purchase_price}', '#{warranty}')"
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
      part = Part.new(car_id: results["CarID"],
                      project_id: results["ProjectID"],
                      name: results["Name"],
                      replacement_date: results["ReplacementDate"],
                      description: results["Description"],
                      manufacturer: results["Manufacturer"],
                      model_num: results["ModelNumber"],
                      vendor: results["Vendor"],
                      purchase_price: results["PurchasePrice"],
                      warranty: results["Warranty"])
      part.send("id=", results["ID"])
      part
    else
      nil
    end
  end

  def self.search(search_term = nil)
    db = Environment.database_connection
    db.results_as_hash = true
    statement = "SELECT Parts.* from Parts WHERE Name LIKE '%#{search_term}%' ORDER BY Name ASC"
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
  end

  def delete
    db = Environment.database_connection
    begin
      statement << "DELETE FROM Parts WHERE ID='#{id}'"
      db.execute(statement)
    rescue Exception=>e
      e
    end
  end

  def self.all
    search
  end

  def purchase_price
    sprintf('%.2f', @purchase_price) if @purchase_price
  end

  def to_s
    "#{name}, #{manufacturer}, #{replacement_date}"
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
    [:car_id, :project_id, :name, :replacement_date, :description, :manufacturer, :model_num, :vendor, :purchase_price, :warranty].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
