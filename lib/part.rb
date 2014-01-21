require 'edmunds_ruby'
require 'net/http'
require 'json'


class Part
  attr_accessor :name,:replacement_date,:description,:manufaturer,:model_number,:vendor,:purchase_price,:warranty

  def initialize name,replacement_date,description,manufaturer,model_number,vendor,purchase_price,warranty
    @name = name
    @replacement_date = replacement_date
    @description = description
    @manufacturer = manufacturer
    @model_number = model_number
    @vendor = vendor
    @purchase_price = purchase_price
    @warranty = warranty
  end



end