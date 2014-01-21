require 'sqlite3'

class DB
  attr_accessor :connect
  def initialize
    @connect = SQLite3::Database.new "data/ruby_auto.sqlite"
  end
end