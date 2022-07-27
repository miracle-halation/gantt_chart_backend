FactoryBot.define do
  factory :group do
    name      { Faker::Name.initials(number: 2) }
  end
end
