require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'instance methods' do
    describe 'Relationships' do
      it {should belong_to :dealership}
    end
  end
end