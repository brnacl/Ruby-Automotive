class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :year
      t.string :make
      t.string :model
      t.string :trim
      t.integer :purchase_mileage
      t.decimal :purchase_price
      t.date :purchase_date
      t.decimal :current_value
      t.integer :current_mileage
    end
  end
end