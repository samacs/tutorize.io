module PasswordResettable
  extend ActiveSupport::Concern

  PASSWORD_RESET_TOKEN_EXPIRATION_TIME = 24.hours

  included do
    include Tokenizable unless self <= Tokenizable

    scope :by_password_reset_token, ->(password_reset_token) { where(password_reset_token:) }

    validates :password_reset_token,
              uniqueness: true,
              allow_blank: true
  end

  def password_reset_token_expired?
    (password_reset_token_sent_at + PASSWORD_RESET_TOKEN_EXPIRATION_TIME).before?(Time.current)
  end

  def generate_password_reset_token!
    generate_token(:password_reset_token)

    save!
  end

  def password_reset_token_sent!
    self.password_reset_token_sent_at = Time.zone.now

    save!
  end

  def clear_password_reset!
    self.password_reset_token_sent_at = nil
    self.password_reset_token = nil

    save!
  end

  def resetting_password?
    password_reset_token_sent_at.present? && password_reset_token.present?
  end

  # def send_password_reset_email!
  #   UserMailerWorker.perform_async(id, 'password_reset_email')

  #   password_reset_token_sent!
  # end
end
