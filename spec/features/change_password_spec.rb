require 'rails_helper'

RSpec.describe 'Change password' do
  let(:user) { create(:user, :confirmed) }
  let(:email) { user.email }

  before do
    reset_password(user.email)

    user.reload
  end

  describe 'when new password is correct' do
    let(:password) { Faker::Internet.password }
    let(:password_confirmation) { password }
    let(:expected_message) { t('password_resets.update.success') }

    before { change_password(user:, password:, password_confirmation: password) }

    it 'redirects the user to the sign in page with a success message' do
      expect(page).to have_current_path sign_in_path
      expect(page).to have_content(expected_message)
    end
  end

  describe "when password don't match" do
    let(:password) { Faker::Internet.password }
    let(:password_confirmation) { Faker::Internet.password }
    let(:expected_message) { "Password confirmation doesn't match Password" }

    before { change_password(user:, password:, password_confirmation:) }

    it 'displays the validation error' do
      expect(page).to have_current_path change_password_path
      expect(page).to have_content expected_message
    end
  end

  describe 'when the user is not found' do
    let(:email) { Faker::Internet.email }
    let(:expected_error) { t('password_resets.edit.user_not_found_error') }

    before do
      visit change_password_path(email:, password_reset_token: user.password_reset_token)
    end

    it 'redirects the user to the reset password form and shows the error message' do
      expect(page).to have_current_path reset_password_path
      expect(page).to have_content expected_error
    end
  end

  describe 'when the password reset token has expired' do
    let(:password_reset_token) { user.reload.password_reset_token }
    let(:expected_error) { t('password_resets.edit.password_reset_token_expired_error') }

    before do
      user.update(password_reset_token_sent_at: 2.days.ago)

      visit change_password_path(email:, password_reset_token:)
    end

    it 'redirects the user to the reset password form and shows the error message' do
      expect(page).to have_current_path reset_password_path
      expect(page).to have_content expected_error
    end
  end
end
