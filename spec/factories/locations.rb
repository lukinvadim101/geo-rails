# frozen_string_literal: true

FactoryBot.define do
  factory :location1 do
    name { 'Location' }
    latitude { 1.5 }
    longitude { 1.5 }
    user_id { 1 }
  end
end
