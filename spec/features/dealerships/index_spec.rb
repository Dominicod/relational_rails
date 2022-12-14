require 'rails_helper'

RSpec.describe "Dealership index_page", type: :feature do
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

      dealer_toyota = find("#id_#{@dealer_1.id}")
      dealer_ford = find("#id_#{@dealer_2.id}")
      dealer_nissan = find("#id_#{@dealer_3.id}")

      expect(dealer_toyota).to appear_before(dealer_ford)
      expect(dealer_ford).to appear_before(dealer_nissan)
      expect(page).to have_content(@dealer_1.created_at)
      expect(page).to have_content(@dealer_2.created_at)
      expect(page).to have_content(@dealer_3.created_at)
    end

    it 'I can click a update dealership button from the dealership index page' do
      dealerships = [@dealer_1, @dealer_2, @dealer_3]

      dealerships.each do |dealer|
        visit "/dealerships"
        within "#id_#{dealer.id}" do
          expect(page.has_link?).to eq true
          click_link "Update Dealership"

          expect(current_path).to eq("/dealerships/#{dealer.id}/edit")
        end
      end
    end

    it 'I can click a delete dealership button from the dealership index page' do
      dealerships = [@dealer_1, @dealer_2, @dealer_3]

      visit "/dealerships"

      dealerships.each do |dealer|
        within "#id_#{dealer.id}" do
          expect(page.has_link?).to eq true
          click_button "Delete Dealership"

          expect(current_path).to eq("/dealerships")
        end
      end
    end
  end
end