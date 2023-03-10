# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    name { 'Location' }
    latitude { 1.5 }
    longitude { 1.5 }
    user_id { 1 }
    is_private { true }
  end
end
