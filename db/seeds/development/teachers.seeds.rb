after :common do
  1.upto(5) do |n|
    email = "teacher#{n}@tutorize.io"
    next if user_exists?(email)

    teacher = create_user(email, :teacher)

    create_weekly_availability(teacher)

    rand((3..5)).times do
      course = create_course(teacher)

      rand((5..10)).times do
        create_lesson(teacher, course)
      end
    end
  end
end
