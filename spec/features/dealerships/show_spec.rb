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

  describe '#show' do
    it "When I visit '/dealerships/:id', I see the dealerships with that id including the dealership's attributes" do
      visit "/dealerships/#{@dealer_1.id}"

      expect(page).to have_content("Dealership name: #{@dealer_1.name}")
      expect(page).to have_content("Dealership lot size: #{@dealer_1.vehicle_lot_size}")
      expect(page).to have_content("Service center: #{@dealer_1.service_center}")
      expect(page).to have_content("Car-wash center: #{@dealer_1.car_wash}")

      expect(page).to have_link('', href: '/dealerships')
      expect(page).to have_link('', href: '/vehicles')
      expect(page).to have_link('', href: "/dealerships/#{@dealer_1.id}/vehicles")
    end

    it "When I visit '/dealerships/:id', the page only has information on the given id" do
      visit "/dealerships/#{@dealer_1.id}"

      expect(page).to_not have_content("Dealership name: #{@dealer_2.name}")
      expect(page).to_not have_content("Dealership name: #{@dealer_3.name}")
    end

    it "As a visitor, when I visit a dealership's show page, I see the vehicles count." do
      visit "/dealerships/#{@dealer_2.id}"

      expect(page).to have_content("Current vehicle count: #{@dealer_2.vehicles.count}")
    end

    it 'Update Dealership link in show page is present, takes user to "/parents/:id/edit" to where they can submit a form that edits the DB' do
      visit "/dealerships/#{@dealer_1.id}"
      dealer_name = "Suzuki"
      dealer_lot_size = 50

      click_link "Update Dealership"

      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealer_1.id}/edit")

      expect(page.has_field?).to eq true

      fill_in "dealer[name]", with: dealer_name
      fill_in "dealer[lot_size]", with: dealer_lot_size
      uncheck "dealer[service_center]"
      check "dealer[car_wash]"

      click_on "Update Dealership"

      expect(current_url).to eq("http://www.example.com/dealerships/#{@dealer_1.id}")

      within "#id_#{@dealer_1.id}" do
        expect(page).to have_content("Dealership name: #{dealer_name}")
        expect(page).to have_content("Dealership lot size: #{dealer_lot_size}")
        expect(page).to have_content("Service center: #{false}")
        expect(page).to have_content("Car-wash center: #{true}")
      end
    end

    it 'I can delete dealerships from the dealership show page' do
      visit "/dealerships/#{@dealer_2.id}"

      click_button "Delete Dealership"

      expect(current_url).to eq("http://www.example.com/dealerships")

      expect(page).to_not have_content("Dealership name: #{@dealer_2.name}")
    end
  end
end