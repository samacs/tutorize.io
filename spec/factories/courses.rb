FactoryBot.define do
  factory :course do
    name { Faker::Educator.subject }
    description { Faker::Lorem.paragraphs(number: rand(10..20)).join("\r\n") }
    association :teacher, factory: %i[user teacher confirmed]
  end
end
