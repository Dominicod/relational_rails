class Dealership < ApplicationRecord
  has_many :vehicles, :dependent => :destroy
  validates_presence_of :name
  validates_presence_of :vehicle_lot_size

  def vehicles_count
    vehicles.count
  end
end