require 'rails_helper'

RSpec.describe User do
  describe 'inheritance' do
    subject { described_class }

    it { is_expected.to be <= Tokenizable }

    it_behaves_like Confirmable
  end

  describe 'has a valid factory' do
    subject(:user) { build(:user) }

    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:password) }
    # Confirmation token is validate in the Confirmable concern
    # it { is_expected.to validate_presence_of(:confirmation_token) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_acceptance_of(:terms_of_service).on(:create) }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.not_to allow_value('user').for(:email) }
    it { is_expected.not_to allow_value('@example.com').for(:email) }
  end
end
