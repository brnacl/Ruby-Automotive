class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :car_id
      t.integer :project_id
      t.string :name
      t.date :replacement_date
      t.text :description
      t.string :manufacturer
      t.string :model_number
      t.string :vendor
      t.decimal :purchase_price
      t.boolean :warranty
    end
  end
end