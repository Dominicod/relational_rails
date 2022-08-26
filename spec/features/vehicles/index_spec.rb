require 'rails_helper'

RSpec.describe "Vehicles index_page", type: :feature do
  before(:each) do
    @dealer_1 = Dealership.create!(name: "Toyota", vehicle_lot_size: 10, service_center: true, car_wash: false)
    @dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
    @dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)

    @vehicle_1 = @dealer_1.vehicles.create!(name: "Supra", cylinder_count: 6, luxury_model: true, horsepower: 382, torque: 368)
    @vehicle_2 = @dealer_1.vehicles.create!(name: "Rav-4", cylinder_count: 4, luxury_model: true, horsepower: 203, torque: 142)
    @vehicle_3 = @dealer_2.vehicles.create!(name: "Mustang GT Fastback", cylinder_count: 8, luxury_model: true, horsepower: 450, torque: 410)
    @vehicle_4 = @dealer_2.vehicles.create!(name: "Ford GT", cylinder_count: 6, luxury_model: true, horsepower: 660, torque: 634)
    @vehicle_5 = @dealer_3.vehicles.create!(name: "GTR", cylinder_count: 6, luxury_model: false, horsepower: 600, torque: 481)
  end

  describe '#index' do
    it "When I visit '/vehicles', I see each Vehicle in the system including the Vehicle's attributes" do
      visit "/vehicles"

      vehicles = [@vehicle_1, @vehicle_2, @vehicle_3, @vehicle_4, @vehicle_5]

      vehicles.each do |vehicle|
        within "#id_#{vehicle.id}" do
          expect(page).to have_content("Vehicle name: #{vehicle.name}")
          expect(page).to have_content("Vehicle cylinder count: #{vehicle.cylinder_count}")
          expect(page).to have_content("This vehicle has the luxury model: #{vehicle.luxury_model}")
          expect(page).to have_content("Vehicle horsepower: #{vehicle.horsepower}")
          expect(page).to have_content("Vehicle torque: #{vehicle.torque}")
        end
      end

      expect(page).to have_link('', href: '/dealerships')
      expect(page).to have_link('', href: '/vehicles')
    end

    it "When I visit '/vehicles' I only see true records" do
      visit "/vehicles"

      vehicles = [@vehicle_1, @vehicle_2, @vehicle_3, @vehicle_4]

      vehicles.each do |vehicle|
        within "#id_#{vehicle.id}" do
          expect(page).to have_content("Vehicle name: #{vehicle.name}")
          expect(page).to have_content("Vehicle cylinder count: #{vehicle.cylinder_count}")
          expect(page).to have_content("This vehicle has the luxury model: #{vehicle.luxury_model}")
          expect(page).to have_content("Vehicle horsepower: #{vehicle.horsepower}")
          expect(page).to have_content("Vehicle torque: #{vehicle.torque}")
        end
      end

      expect(page).to_not have_content("Vehicle name: #{@vehicle_5.name}")
    end
  end
end