class Project < ActiveRecord::Base

  default_scope { order("title ASC") }

  def self.search(search_term = nil)
    Project.where("title LIKE ?", "%#{search_term}%").to_a
  end

  def formatted_start_date
    start_date.to_s
  end

  def parts
    Part.where("project_id = '#{self.id}'").to_a
  end

  def to_s
    "#{title}, #{mileage} miles, #{formatted_start_date}"
  end

end
