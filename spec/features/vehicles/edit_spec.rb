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

  describe '#edit' do
    it "When I visit '/vehicles/:id' I see a link to update that vehicle which takes me to '/vehicles/:id/edit' so I can update the vehicle" do
      visit "/vehicles/#{@vehicle_1.id}"
      vehicle_name = "GR86"
      vehicle_cylinders = 4
      vehicle_hp = 228
      vehicle_tq = 200

      click_link "Update Vehicle"

      expect(current_path).to eq("/vehicles/#{@vehicle_1.id}/edit")

      expect(page.has_field?).to eq true

      fill_in "name", with: vehicle_name
      fill_in "cylinder_count", with: vehicle_cylinders
      fill_in "horsepower", with: vehicle_hp
      fill_in "torque", with: vehicle_tq
      choose "luxury_model_true"

      click_on "Update Vehicle"

      expect(current_path).to eq("/vehicles/#{@vehicle_1.id}")

      within "#id_#{@vehicle_1.id}" do
        expect(page).to have_content("Vehicle name: #{vehicle_name}")
        expect(page).to have_content("Vehicle cylinder count: #{vehicle_cylinders}")
        expect(page).to have_content("This vehicle has the luxury model: #{true}")
        expect(page).to have_content("Vehicle horsepower: #{vehicle_hp}")
        expect(page).to have_content("Vehicle torque: #{vehicle_tq}")
      end
    end
  end
end
