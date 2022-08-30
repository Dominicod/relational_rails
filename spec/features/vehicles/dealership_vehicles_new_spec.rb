require 'rails_helper'

RSpec.describe "Dealership_vehicles_new_page", type: :feature do
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

  describe '#dealership_vehicles_new' do
    it "When I visit '/dealerships/:dealership_id/vehicles', I see a link to add a new adoptable Vehicle for that parent 'Create Vehicle' which allows me to make a new vehicle" do
      visit "/dealerships/#{@dealer_2.id}/vehicles"
      vehicle_name = "Explorer"
      vehicle_cylinders = 6
      vehicle_hp = 400
      vehicle_tq = 415

      click_link "Create Vehicle"

      expect(current_path).to eq("/dealerships/#{@dealer_2.id}/vehicles/new")

      expect(page.has_field?).to eq true

      fill_in "name", with: vehicle_name
      fill_in "cylinder_count", with: vehicle_cylinders
      fill_in "horsepower", with: vehicle_hp
      fill_in "torque", with: vehicle_tq
      choose "luxury_model_true"

      click_on "Create Vehicle"

      expect(current_path).to eq("/dealerships/#{@dealer_2.id}/vehicles")

      within "#id_#{Vehicle.last.id}" do
        expect(page).to have_content("Vehicle name: #{vehicle_name}")
        expect(page).to have_content("Vehicle cylinder count: #{vehicle_cylinders}")
        expect(page).to have_content("This vehicle has the luxury model: true")
        expect(page).to have_content("Vehicle horsepower: #{vehicle_hp}")
        expect(page).to have_content("Vehicle torque: #{vehicle_tq}")
      end
    end
  end
end