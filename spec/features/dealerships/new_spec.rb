
require 'rails_helper'

RSpec.describe "Dealership new_page", type: :feature do
  before(:each) do
    @dealer_1 = Dealership.create!(name: "Toyota", vehicle_lot_size: 10, service_center: true, car_wash: false)
    @dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
    @dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)
  end

  describe "#new" do
    it 'New dealership link in index is present, takes user to "/parents/new" to where they can submit a form that updates the DB' do
      visit "/dealerships"
      dealer_name = "Audi"
      dealer_lot_size = 30

      click_link "New Dealership"

      expect(current_path).to eq("/dealerships/new")

      expect(page.has_field?).to eq true

      fill_in "name", with: dealer_name
      fill_in "vehicle_lot_size", with: dealer_lot_size
      choose "service_center_true"
      choose "car_wash_false"

      click_on "Create Dealership"

      expect(current_path).to eq("/dealerships")

      within "#id_#{Dealership.last.id}" do
        expect(page).to have_content("Dealership name: #{dealer_name}")
        expect(page).to have_content(Dealership.last.created_at)
      end
    end
  end
end