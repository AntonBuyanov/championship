FactoryBot.define do
  factory :match do
    association :team_first, factory: :team
    association :team_second, factory: :team
  end
end
