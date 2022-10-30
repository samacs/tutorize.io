FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    terms_of_service { true }
    sign_up_role { User::STUDENT_ROLE }

    after(:create) do |user, _evaluator|
      user.add_role user.sign_up_role unless user.has_role?(user.sign_up_role)
    end

    trait :confirmed do
      confirmation_token_sent_at { Time.current }
      confirmed_at { Time.current }
    end

    trait :teacher do
      sign_up_role { User::TEACHER_ROLE }
    end

    trait :student do
      sign_up_role { User::STUDENT_ROLE }
    end

    factory :student, traits: %i[student]
    factory :teacher, traits: %i[teacher]
  end
end
