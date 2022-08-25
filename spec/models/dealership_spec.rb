require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :vehicle_lot_size}
  end

  describe 'instance methods' do
    describe 'Relationships' do
      it {should have_many :vehicles}
    end

    describe 'vehicles_count' do
      it 'returns the vehicle count' do
        dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
        dealer_2.vehicles.create!(name: "Mustang GT Fastback", cylinder_count: 8, luxury_model: false, horsepower: 450, torque: 410)
        dealer_2.vehicles.create!(name: "Ford GT", cylinder_count: 6, luxury_model: true, horsepower: 660, torque: 634)

        expect(dealer_2.vehicles_count).to eq 2

        dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)
        dealer_3.vehicles.create!(name: "GTR", cylinder_count: 6, luxury_model: true, horsepower: 600, torque: 481)

        expect(dealer_3.vehicles_count).to eq 1
      end
    end
  end
end
