FactoryBot.define do
  factory :location do
    name { "MyText" }
    latitude { 1.5 }
    longitude { 1.5 }
    user_id { 1 }
  end
end
