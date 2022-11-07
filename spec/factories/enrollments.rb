FactoryBot.define do
  factory :enrollment do
    scheduled_at { "2022-11-03 23:45:40" }
    student { nil }
    lecture { nil }
  end
end
