require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'instance methods' do
    # let(:) { i = '' }
    describe '#index' do
      it "When I visit '/dealerships', I see the name of each dealership record in the system"
    end

    describe '#show' do
      it "When I visit '/dealerships/:id', I see the dealership with that id including the dealership's attributes"
    end

    describe '#parent_children_index' do
      it "When I visit '/dealerships/:dealership_id/vehicles', I see each Vehicle that is associated with that Dealership with each Vehicles's attributes"
    end
  end
end
