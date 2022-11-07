after 'development:teachers' do
  1.upto(5) do |n|
    email = "student#{n}@tutorize.io"
    next if user_exists?(email)

    student = create_user(email, :student)

    from_date = Time.current
    to_date = from_date + rand((10..15)).days
    rand((3..5)).times do
      lesson, date, available_time_slots = loop do
        lesson = Lesson.newest.sample
        available = lesson.available_time_slots(from_date, to_date)
        date = available.keys.sample
        time_slot = available[date]
        break [lesson, date, time_slot] if time_slot.any?
      end
      available_time_slot = available_time_slots.to_a.sample
      start_time = date + available_time_slot.begin.hours
      end_time = start_time + lesson.duration.hours
      lesson.enroll(student, start_time, end_time)
    end
  end
end
