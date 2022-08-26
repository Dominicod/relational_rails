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

    it "When I visit '/vehicles/:id' I see a link to update that vehicle which takes me to '/vehicles/:id/edit' so I can update the vehicle" do
      visit "/vehicles/#{@vehicle_1.id}"
      vehicle_name = "GR86"

      click_link "Update Vehicle"

      expect(current_url).to eq("http://www.example.com/vehicles/#{@vehicle_1.id}/edit")

      expect(page.has_field?).to eq true

      fill_in "vehicle[name]", with: vehicle_name
      fill_in "vehicle[cylinder_count]", with: 4
      fill_in "vehicle[horsepower]", with: 228
      fill_in "vehicle[torque]", with: 200
      check "vehicle[luxury_model]"

      click_on "Update Vehicle"

      expect(current_url).to eq("http://www.example.com/vehicles/#{@vehicle_1.id}")


      expect(page).to have_content("#{vehicle_name}")
      expect(page).to have_content(4)
      expect(page).to have_content(228)
      expect(page).to have_content(200)
    end
  end
end