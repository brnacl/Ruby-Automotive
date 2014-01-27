require 'edmunds_ruby'
require 'net/http'
require 'json'


class Part
  attr_accessor :PartID,:CarID,:ProjectID,:name,:replacement_date,:description,:manufaturer,:model_number,:vendor,:purchase_price,:warranty

  def initialize attributes = {}
    [:CarID,:ProjectID,:name,:replacement_date,:description,:manufaturer,:model_number,:vendor,:purchase_price,:warranty].each do |attr|
      self.send("#{attr}"=), attributes[attr])
    end
  end



end