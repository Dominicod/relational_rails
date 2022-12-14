require 'rails_helper'

RSpec.describe "Dealership show_page", type: :feature do
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
    it 'Update Dealership link in show page is present, takes user to "/parents/:id/edit" to where they can submit a form that edits the DB' do
      visit "/dealerships/#{@dealer_1.id}"
      dealer_name = "Suzuki"
      dealer_lot_size = 50

      click_link "Update Dealership"

      expect(current_path).to eq("/dealerships/#{@dealer_1.id}/edit")

      expect(page.has_field?).to eq true

      fill_in "name", with: dealer_name
      fill_in "vehicle_lot_size", with: dealer_lot_size
      choose "service_center_false"
      choose "car_wash_true"

      click_on "Update Dealership"

      expect(current_path).to eq("/dealerships/#{@dealer_1.id}")

      within "#id_#{@dealer_1.id}" do
        expect(page).to have_content("Dealership name: #{dealer_name}")
        expect(page).to have_content("Dealership lot size: #{dealer_lot_size}")
        expect(page).to have_content("Service center: #{false}")
        expect(page).to have_content("Car-wash center: #{true}")
      end
    end
  end
end