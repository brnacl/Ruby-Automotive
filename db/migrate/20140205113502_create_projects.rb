class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :car_id
      t.string :title
      t.text :description
      t.integer :mileage
      t.date :start_date
    end
  end
end