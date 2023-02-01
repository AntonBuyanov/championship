FactoryBot.define do
  factory :indicator do
    name { Faker::Coin.name }
  end
end
