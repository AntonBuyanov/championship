FactoryBot.define do
  factory :player do
    name { Faker::Sports::Football.player }
    number { Faker::Number.decimal_part(digits: 3) }
    team
  end
end
