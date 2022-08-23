require 'rails_helper'

RSpec.describe Dealership, type: :model do
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
      it "When I visit '/dealerships', I see the name of each dealership record in the system" do
        visit "/dealerships"

        expect(page).to have_content(@dealer_1.name)
        expect(page).to have_content(@dealer_2.name)
        expect(page).to have_content(@dealer_3.name)
      end
    end

    describe '#show' do
      xit "When I visit '/dealerships/:id', I see the dealership with that id including the dealership's attributes" do
        visit "/dealerships/#{@dealer_1.id}"

        expect(page).to have_content(@dealer_1.name)
        expect(page).to have_content(@dealer_1.vehicle_lot_size)
        expect(page).to have_content(@dealer_1.service_center)
        expect(page).to have_content(@dealer_1.car_wash)
      end

      xit "When I visit '/dealerships/:id', the page only has information on the given id" do
        visit "/dealerships/#{@dealer_1.id}"

        expect(page).to_not have_content(@dealer_2.name)
        expect(page).to_not have_content(@dealer_3.name)
      end
    end

    describe '#dealership_vehicles_index' do
      xit "When I visit '/dealerships/:dealership_id/vehicles', I see each Vehicle that is associated with that Dealership with each Vehicle's attributes" do
        visit "/dealerships/#{@dealer_2.id}/vehicles"

        vehicles = [@vehicle_3, @vehicle_4]

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

      xit "When I visit '/dealerships/:dealership_id/vehicles', I do not see vehicles that the dealership does not have on the lot" do
        visit "/dealerships/#{@dealer_2.id}/vehicles"

        expect(page).to_not have_content(@vehicle_5.name)
        expect(page).to_not have_content(@vehicle_1.name)
        expect(page).to_not have_content(@vehicle_2.name)
      end
    end
  end
end
