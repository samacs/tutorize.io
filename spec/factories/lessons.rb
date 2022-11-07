FactoryBot.define do
  factory :lesson do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraphs(number: rand(10..20)).join("\r\n") }
    minimum_students { 1 }
    maximum_students { rand(3..5) }
    duration { (1.0..3.0).step(0.25).to_a.sample }
    course
    teacher { course.teacher }
  end
end
