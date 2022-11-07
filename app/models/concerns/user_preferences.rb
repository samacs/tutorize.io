module UserPreferences
  extend ActiveSupport::Concern

  DEFAULT_TIME_ZONE = 'UTC'.freeze
  DEFAULT_LOCALE    = 'en'.freeze

  included do
    include Storext.model

    store_attributes :preferences do
      time_zone String, default: DEFAULT_TIME_ZONE
      locale String, default: DEFAULT_LOCALE
      sidebar_open String, default: 'false'
    end

    before_create :set_default_preferences
  end

  def sidebar_open?
    preferences['sidebar_open'] == 'true'
  end

  private

  def set_default_preferences
    default_preferences.each do |key, value|
      preferences[key] = value if preferences[key].blank?
    end
  end

  def default_preferences
    { 'time_zone' => DEFAULT_TIME_ZONE, 'locale' => DEFAULT_LOCALE }
  end
end
