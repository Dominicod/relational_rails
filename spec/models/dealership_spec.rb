require 'rails_helper'

RSpec.describe Dealership, type: :model do
  describe 'instance methods' do
    describe 'Relationships' do
      it {should have_many :vehicles}
    end
  end
end
