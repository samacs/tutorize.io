class AvailabilityDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def title
    return "Availability for #{Date::DAYNAMES[weekday]}" if weekday.present?
    return "Availability for #{date.strftime('%Y-%m-%d')}" if date.present?
  end

  def turbo_frame_selector
    return "#{date.to_date}-date-availabilities" if date.present?
    return "#{Date::DAYNAMES[weekday].downcase}-availabilities" if weekday.present?
  end

  def availability_css_class
    return 'link-danger' unless available?

    'link-success'
  end
end
