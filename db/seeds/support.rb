module Support
  def user_exists?(email)
    User.exists?(email:)
  end

  def create_user(email, role)
    password = email.split(/@/).first
    create(role, :confirmed, email:, password:)
  end

  def create_weekly_availability(teacher, morning_hours: (9.0..13.0), afternoon_hours: (14.0..18.0))
    1.upto(6) do |weekday|
      teacher.availabilities.create!(weekday:, from: morning_hours.begin, to: morning_hours.end)
      teacher.availabilities.create!(weekday:, from: afternoon_hours.begin, to: afternoon_hours.end) if weekday < 6
    end
  end

  def create_course(teacher)
    create(:course, teacher:)
  end

  def create_lesson(teacher, course)
    create(:lesson, teacher:, course:)
  end
end
