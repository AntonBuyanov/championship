FactoryBot.define do
  sequence :name do |n|
    "name#{n}"
  end

  factory :team do
    name
  end
end
