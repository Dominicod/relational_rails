class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.timestamps
      t.string :name
      t.integer :cylinder_count
      t.boolean :luxury_model
      t.integer :horsepower
      t.integer :torque
    end
  end
end
