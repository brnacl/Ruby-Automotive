require 'edmunds_ruby'
require 'net/http'
require 'json'


class Project
  attr_accessor :title, :description, :mileage

  def initialize title, description, mileage
    @title = title
    @description = description
    @mileage = mileage
  end



end