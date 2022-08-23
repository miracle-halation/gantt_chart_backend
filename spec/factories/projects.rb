FactoryBot.define do
  factory :project do
    title {Faker::Name.initials(number: 10)}
    category {'システム開発'}
    url {'test.domain.com'}
    deadline {Faker::Date.in_date_period}
  end
end
