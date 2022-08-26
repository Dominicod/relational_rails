require 'rails_helper'

RSpec.describe "Vehicle show_page", type: :feature do
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

  describe '#show' do
    it "When I visit '/vehicles/:id', I see the vehicle with that id including the vehicle's attributes" do
      visit "/vehicles/#{@vehicle_2.id}"

      expect(page).to have_content("Vehicle name: #{@vehicle_2.name}")
      expect(page).to have_content("Vehicle cylinder count: #{@vehicle_2.cylinder_count}")
      expect(page).to have_content("This vehicle has the luxury model: #{@vehicle_2.luxury_model}")
      expect(page).to have_content("Vehicle horsepower: #{@vehicle_2.horsepower}")
      expect(page).to have_content("Vehicle torque: #{@vehicle_2.torque}")

      expect(page).to have_link('', href: '/dealerships')
      expect(page).to have_link('', href: '/vehicles')
    end

    it "When I visit '/vehicles/:id', I don't see vehicles not associated to the id I requested" do
      visit "/vehicles/#{@vehicle_2.id}"

      expect(page).to_not have_content("Vehicle name: #{@vehicle_3.name}")
      expect(page).to_not have_content("Vehicle name: #{@vehicle_1.name}")
      expect(page).to_not have_content("Vehicle name: #{@vehicle_4.name}")
    end
  end
end