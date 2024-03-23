FactoryBot.define do
  factory :indicator do
    name { Faker::Alphanumeric.alpha(number: 10) }
  end
end
