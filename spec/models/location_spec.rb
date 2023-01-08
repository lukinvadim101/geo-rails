# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2) }

    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:latitude) }
    it { should validate_numericality_of(:latitude) }

    it { should validate_presence_of(:longitude) }
    it { should validate_numericality_of(:longitude) }

    it { should validate_presence_of(:is_private) }
  end
end
