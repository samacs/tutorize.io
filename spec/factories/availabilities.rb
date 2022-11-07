FactoryBot.define do
  factory :availability do
    date { "2022-10-31 14:09:37" }
    weekday { 1 }
    from { "9.99" }
    to { "9.99" }
    available { false }
    teacher { nil }
  end
end
