require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :vehicle_lot_size}
  end

  describe 'instance methods' do
    before(:each) do
      @dealer_1 = Dealership.create!(name: "Toyota", vehicle_lot_size: 10, service_center: true, car_wash: false)
      @dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
      @dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)

      @vehicle_1 = @dealer_1.vehicles.create!(name: "Supra", cylinder_count: 6, luxury_model: true, horsepower: 382, torque: 368)
      @vehicle_2 = @dealer_1.vehicles.create!(name: "Rav-4", cylinder_count: 4, luxury_model: true, horsepower: 203, torque: 142)
      @vehicle_3 = @dealer_2.vehicles.create!(name: "Mustang GT Fastback", cylinder_count: 8, luxury_model: true, horsepower: 450, torque: 410)
      @vehicle_4 = @dealer_2.vehicles.create!(name: "Ford GT", cylinder_count: 6, luxury_model: true, horsepower: 660, torque: 634)
      @vehicle_5 = @dealer_3.vehicles.create!(name: "GTR", cylinder_count: 6, luxury_model: true, horsepower: 600, torque: 481)
    end

    describe 'Relationships' do
      it {should have_many :vehicles}
    end

    describe 'vehicles_count' do
      it 'returns the vehicle count' do
        expect(@dealer_1.vehicles_count).to eq 2
        expect(@dealer_2.vehicles_count).to eq 2
        expect(@dealer_3.vehicles_count).to eq 1
      end
    end

    describe 'alphabetical_vehicles' do
      it 'returns vehicles in alphabetical order' do
        expect(@dealer_1.alphabetical_vehicles).to eq [@vehicle_2, @vehicle_1]
        expect(@dealer_2.alphabetical_vehicles).to eq [@vehicle_4, @vehicle_3]
        expect(@dealer_3.alphabetical_vehicles).to eq [@vehicle_5]
      end
    end

    describe 'cylinder_threshold' do
      it 'returns vehicles with a threshold over the given argument' do
        expect(@dealer_1.cylinder_threshold(4)).to eq [@vehicle_1]
        expect(@dealer_2.cylinder_threshold(5)).to eq [@vehicle_3, @vehicle_4]
        expect(@dealer_3.cylinder_threshold(10)).to eq []
      end
    end
  end
end
