class User < ApplicationRecord
  include Storext.model
  include Tokenizable
  include Confirmable

  DEFAULT_TIME_ZONE = 'UTC'.freeze
  DEFAULT_LOCALE    = 'en'.freeze

  has_secure_password

  store_attributes :preferences do
    time_zone String, default: DEFAULT_TIME_ZONE
    locale String, default: DEFAULT_LOCALE
  end

  validates :first_name,
            :last_name,
            :confirmation_token,
            presence: true
  validates :password,
            confirmation: true,
            presence: true,
            if: :changing_password?
  validates :terms_of_service,
            acceptance: { accepts: true },
            allow_nil: false,
            on: :create

  before_validation :downcase_email!

  before_create :set_default_preferences

  def password=(value)
    @changing_password = true if value.present?

    super
  end

  private

  def downcase_email!
    email.downcase! if email.present?
  end

  def changing_password?
    @changing_password || false
  end

  def set_default_preferences
    default_preferences.each do |key, value|
      preferences[key] = value if preferences[key].blank?
    end
  end

  def default_preferences
    { 'time_zone' => DEFAULT_TIME_ZONE, 'locale' => DEFAULT_LOCALE }
  end
end
