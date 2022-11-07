from_date = Time.zone.parse('2022-10-31T00:00:00+00:00')
to_date = Time.zone.parse('2022-12-04T23:59:59+00:00')
lesson = Lesson.find(72)
puts lesson.available_time_slots(from_date, to_date).inspect

# teacher = User.teacher.sample
# lesson, date, available_time_slots = loop do
#   lesson = teacher.lessons.sample
#   available = lesson.available_time_slots(from_date, to_date)
#   puts "Available time slots: #{available.inspect}"
#   date = available.keys.sample
#   puts "Date: #{date}"
#   time_slot = available[date]
#   break [lesson, date, time_slot] if time_slot.any?
# end
# puts "Available time slots for #{lesson.name} on #{date}: #{available_time_slots.inspect}"
# available_time_slot = available_time_slots.to_a.sample
# puts "Selected: #{available_time_slot.inspect}"
# start_time = date + available_time_slot.begin.hours
# end_time = start_time + lesson.duration.hours
# puts "Available time slot for #{lesson.name} on #{date} from #{start_time} to #{end_time}"
# # intervals = {}
# # availabilities.each do |date, availabilities|
# #   intervals[date] ||= IntervalSet.new
# #   availabilities.each_with_index do |availability, _index|
# #     puts availability.step(lesson.duration).to_a.inspect
# #   end
# # end
