module Tokenizable
  extend ActiveSupport::Concern

  DEFAULT_TOKEN_LENGTH = 32
  TOKENIZABLE_FIELDS = %i[confirmation_token password_reset_token slug].freeze

  def generate_token(field, length = DEFAULT_TOKEN_LENGTH)
    rails ArgumentError, "Invalid tokenizable field: #{field}." unless TOKENIZABLE_FIELDS.include?(field)

    self[field] = loop do
      token = SecureRandom.urlsafe_base64(length)
      break token unless duplicated_token?(field, token)
    end
  end

  def duplicated_token?(field, token)
    self.class.unscoped.where.not(id: id).exists?(["#{field} = ?", token])
  end
end
