FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    phone { '000-0000-0000' }
    group { 'システム部' }
    association :user
  end
end
