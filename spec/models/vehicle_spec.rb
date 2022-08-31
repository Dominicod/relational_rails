require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :cylinder_count}
    it {should validate_presence_of :torque}
    it {should validate_presence_of :horsepower}
    it {should validate_presence_of :dealership_id}
  end
  describe 'Relationships' do
    it {should have_many :vehicles}
  end
end