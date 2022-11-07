class TimeSlot
  def initialize(date:, from_time:, to_time:, available:)
    @from_time = from_time
    @to_time = to_time
    @date = date
    @available = available
  end
end
