class Part < ActiveRecord::Base

  default_scope { order("name ASC") }

  def self.search(search_term = nil)
    Part.where("name LIKE ?", "%#{search_term}%").to_a
  end

  def formatted_purchase_price
    "$%04.2f" % purchase_price
  end

  def formatted_replacement_date
    replacement_date.to_s
  end

  def to_s
    "#{name}, #{manufacturer}, #{formatted_replacement_date}"
  end

end
