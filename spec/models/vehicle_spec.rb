require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'instance methods' do
    before(:each) do
      @dealer_1 = Dealership.create!(name: "Toyota", vehicle_lot_size: 10, service_center: true, car_wash: false)
      @dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
      @dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)

      @vehicle_1 = @dealer_1.vehicles.create!(name: "Supra", cylinder_count: 6, luxury_model: true, horsepower: 382, torque: 368)
      @vehicle_2 = @dealer_1.vehicles.create!(name: "Rav-4", cylinder_count: 4, luxury_model: false, horsepower: 203, torque: 142)
      @vehicle_3 = @dealer_2.vehicles.create!(name: "Mustang GT Fastback", cylinder_count: 8, luxury_model: false, horsepower: 450, torque: 410)
      @vehicle_4 = @dealer_2.vehicles.create!(name: "Ford GT", cylinder_count: 6, luxury_model: true, horsepower: 660, torque: 634)
      @vehicle_5 = @dealer_3.vehicles.create!(name: "GTR", cylinder_count: 6, luxury_model: true, horsepower: 600, torque: 481)
    end

    describe '#index' do
      it "When I visit '/vehicles', I see each Vehicle in the system including the Vehicle's attributes" do
        visit "/vehicles"

        vehicles = [@vehicle_1, @vehicle_2, @vehicle_3, @vehicle_4, @vehicle_5]

        vehicles.each do |vehicle|
          within "#vehicle-#{vehicle.id}" do
            expect(page).to have_content(vehicle.name)
            expect(page).to have_content(vehicle.cylinder_count)
            expect(page).to have_content(vehicle.luxury_model)
            expect(page).to have_content(vehicle.horsepower)
            expect(page).to have_content(vehicle.torque)
          end
        end
      end
    end

    describe '#show' do
      xit "When I visit '/vehicles/:id', I see the vehicle with that id including the vehicle's attributes" do
        visit "/vehicles/#{@vehicle_2.id}"

        expect(page).to have_content(@vehicle_2.name)
        expect(page).to have_content(@vehicle_2.cylinder_count)
        expect(page).to have_content(@vehicle_2.luxury_model)
        expect(page).to have_content(@vehicle_2.horsepower)
        expect(page).to have_content(@vehicle_2.torque)
      end

      xit "When I visit '/vehicles/:id', I don't see vehicles not associated to the id I requested" do
        visit "/vehicles/#{@vehicle_2.id}"

        expect(page).to_not have_content(@vehicle_3.name)
        expect(page).to_not have_content(@vehicle_1.name)
        expect(page).to_not have_content(@vehicle_4.name)
      end
    end
  end
end