require 'rails_helper'

RSpec.describe Vehicles, type: :model do
  describe 'instance methods' do
    # let(:) { i = '' }
    describe '#index' do
      it "When I visit '/vehicles', I see each Vehicle in the system including the Vehicle's attributes"
    end

    describe '#show' do
      it "When I visit '/vehicles/:id', I see the vehicle with that id including the vehicle's attributes"
    end
  end
end