module TimeHelpers
  extend ActiveSupport::Concern

  def relative_time(value)
    hours, minutes, seconds = time_parts_from_decimal(value)
    parts = []
    parts << I18n.t('hours', count: hours) if hours.positive?
    parts << I18n.t('minutes', count: minutes) if minutes.positive?
    parts << I18n.t('seconds', count: seconds) if seconds.positive?
    parts.join(', ')
  end

  def time_from_decimal(value)
    hours, minutes, _seconds = time_parts_from_decimal(value)
    Time.zone.parse(format('%<hours>02d:%<minutes>02d', hours:, minutes:)).strftime('%H:%M')
  end

  def time_parts_from_decimal(value)
    seconds = (value * 3600).to_i
    minutes, seconds = seconds.divmod(60)
    hours, minutes = minutes.divmod(60)

    [hours, minutes, seconds]
  end
end
