require 'rails_helper'

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe 'associations' do

    it 'dsdasdas ' do
      Factory(:user) do
        email { Faker::Internet.email }
        password { Faker::Internet.password }
      end
      should belong_to :user
    end
  end


end
