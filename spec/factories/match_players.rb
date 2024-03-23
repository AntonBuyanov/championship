FactoryBot.define do
  factory :match_player do
    association :match
    association :player
    association :team
  end
end
