require 'rails_helper'

RSpec.describe Dealership, type: :feature do
  before(:each) do
    @dealer_1 = Dealership.create!(name: "Toyota", vehicle_lot_size: 10, service_center: true, car_wash: false)
    @dealer_2 = Dealership.create!(name: "Ford", vehicle_lot_size: 12, service_center: true, car_wash: true)
    @dealer_3 = Dealership.create!(name: "Nissan", vehicle_lot_size: 8, service_center: false, car_wash: false)
  end

  describe '#index' do
    it "When I visit '/dealerships', I see the name of each dealerships record in the system" do
      visit "/dealerships"

      expect(page).to have_content(@dealer_1.name)
      expect(page).to have_content(@dealer_2.name)
      expect(page).to have_content(@dealer_3.name)
    end
  end
end