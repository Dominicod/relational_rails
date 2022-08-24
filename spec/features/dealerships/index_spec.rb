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

      expect(page).to have_content("Dealership name: #{@dealer_1.name}")
      expect(page).to have_content("Dealership name: #{@dealer_2.name}")
      expect(page).to have_content("Dealership name: #{@dealer_3.name}")

      expect(page).to have_link('', href: '/dealerships')
      expect(page).to have_link('', href: '/vehicles')
    end

    it "As a visitor, when I visit '/dealerships', the records are ordered by recently created" do
      visit "/dealerships"

      this = find("#id_#{@dealer_1.id}")
      that = find("#id_#{@dealer_2.id}")
      also_this = find("#id_#{@dealer_3.id}")

      expect(this).to appear_before(that)
      expect(that).to appear_before(also_this)
      expect(page).to have_content(@dealer_1.created_at)
      expect(page).to have_content(@dealer_2.created_at)
      expect(page).to have_content(@dealer_3.created_at)
    end
  end
end