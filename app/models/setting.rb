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

  class << self
    def default_email_from
      "#{default_email_name} <#{default_email_address}>"
    end
  end
end
