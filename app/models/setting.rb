class Setting < RailsSettings::Base
  cache_prefix { 'v1' }

  field :title,
        type: :string,
        default: 'Tutorize',
        validates: { presence: true }
  field :default_email_address,
        type: :string,
        default: 'hello@tutorize.io',
        validates: { presence: true }
  field :default_email_name,
        type: :string,
        default: 'Tutorize',
        validates: { presence: true }
  field :maximum_lesson_duration,
        type: :decimal,
        default: 5.0
  field :start_end_minutes_lower_threshold,
        type: :decimal,
        default: 10.0
  field :start_end_minutes_upper_threshold,
        type: :decimal,
        default: 10.0

  class << self
    def default_email_from
      "#{default_email_name} <#{default_email_address}>"
    end
  end
end
