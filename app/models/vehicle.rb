class Vehicle < ApplicationRecord
  belongs_to :dealership
  validates_presence_of :name
  validates_presence_of :cylinder_count
  validates_presence_of :torque
  validates_presence_of :horsepower
  validates_presence_of :dealership_id
  validates_presence_of :dealership_id
end