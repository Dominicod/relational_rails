require 'rails_helper'

RSpec.describe "Dealership_vehicles_index_page", type: :feature do
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

  describe '#dealership_vehicles' do
    it "When I visit '/dealerships/:dealership_id/vehicles', I see each Vehicle that is associated with that Dealership with each Vehicle's attributes" do
      visit "/dealerships/#{@dealer_2.id}/vehicles"

      vehicles = [@vehicle_3, @vehicle_4]

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

    it "When I visit '/dealerships/:dealership_id/vehicles', I do not see vehicles that the dealerships does not have on the lot" do
      visit "/dealerships/#{@dealer_2.id}/vehicles/"

      expect(page).to_not have_content("Vehicle name: #{@vehicle_5.name}")
      expect(page).to_not have_content("Vehicle name: #{@vehicle_1.name}")
      expect(page).to_not have_content("Vehicle name: #{@vehicle_2.name}")
    end

    it "When I visit '/dealerships/:dealership_id/vehicles', I see the vehicles in alphabetical order by name when I click a button" do
      visit "/dealerships/#{@dealer_1.id}/vehicles"

      click_link "Sort alphabetically by Name"

      vehicle_supra = find("#id_#{@vehicle_1.id}")
      vehicle_rav_4 = find("#id_#{@vehicle_2.id}")

      expect(current_path).to eq("/dealerships/#{@dealer_1.id}/alphabetical/vehicles/")

      expect(vehicle_rav_4).to appear_before(vehicle_supra)
    end

    it "When I visit '/dealerships/:dealership_id/vehicles', I see a form that allows me to display records over a given threshold." do
      visit "/dealerships/#{@dealer_1.id}/vehicles"

      expect(page.has_field?).to eq true

      fill_in "threshold", with: 4

      click_on "Only return records with more than `number` of cylinders."

      expect(current_path).to eq("/dealerships/#{@dealer_1.id}/vehicles")

      expect(page).to_not have_content(@vehicle_2.name)
    end
  end
end