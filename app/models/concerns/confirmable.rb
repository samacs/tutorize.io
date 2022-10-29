module Confirmable
  extend ActiveSupport::Concern

  included do
    include Tokenizable unless self <= Tokenizable

    validates :confirmation_token,
              uniqueness: true,
              on: :create

    before_validation :generate_confirmation_token,
                      if: ->(user) { user.confirmation_token.blank? },
                      on: :create

    def confirm!
      self.confirmed_at = Time.current

      save!
    end

    def confirmation_token_sent!
      self.confirmation_token_sent_at = Time.current

      save!
    end

    def confirmed?
      confirmed_at.present?
    end

    def needs_confirmation?
      confirmed_at.blank?
    end

    def skip_confirmation!
      @skip_confirmation = true

      confirmation_token_sent!
      confirm!
    end

    def skip_confirmation?
      @skip_confirmation || false
    end

    private

    def generate_confirmation_token
      generate_token(:confirmation_token)
    end
  end
end
