FactoryBot.define do
  factory :lecture do
    slug { "MyString" }
    starts_at { "2022-11-03 13:36:29" }
    ends_at { "2022-11-03 13:36:29" }
    started_at { "2022-11-03 13:36:29" }
    ended_at { "2022-11-03 13:36:29" }
    lesson { nil }
  end
end
