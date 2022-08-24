class Dealership < ApplicationRecord
  has_many :vehicles
  def vehicles_count
    vehicles.count
  end
end