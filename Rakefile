#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

desc 'create the production database setup'
task :bootstrap_database do
  Environment.environment = "production"
  database = Environment.database_connection
  create_tables(database)
end

desc 'prepare the test database'
task :test_prepare do
  File.delete("db/ruby_auto_test.sqlite")
  Environment.environment = "test"
  database = Environment.database_connection
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE Cars (ID INTEGER PRIMARY KEY  NOT NULL ,Year INTEGER,Make VARCHAR,Model VARCHAR,Trim VARCHAR,PurchaseMileage INTEGER,PurchasePrice INTEGER,PurchaseDate DATETIME,CurrentValue INTEGER,CurrentMileage INTEGER)")
  database_connection.execute("CREATE TABLE Projects (ID INTEGER PRIMARY KEY  NOT NULL ,CarID INTEGER,Title VARCHAR,Description TEXT,Mileage INTEGER,StartDate DATETIME)")
  database_connection.execute("CREATE TABLE Parts (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , CarID INTEGER  NOT NULL, ProjectID INTEGER  NOT NULL, Name VARCHAR, ReplacementDate DATETIME, Description TEXT, Manufacturer VARCHAR, ModelNumber VARCHAR, Vendor VARCHAR, PurchasePrice INTEGER, Warranty BOOL)")
end
