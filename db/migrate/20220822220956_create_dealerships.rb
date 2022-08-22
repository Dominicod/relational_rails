class CreateDealerships < ActiveRecord::Migration[5.2]
  def change
    create_table :dealerships do |t|
      t.timestamps
      t.string :name
      t.integer :vehicle_lot_size
      t.boolean :service_center
      t.boolean :car_wash
    end
  end
end
