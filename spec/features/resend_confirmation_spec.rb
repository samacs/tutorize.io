require 'rails_helper'

RSpec.describe 'Resend confirmation' do
  let(:user) { create(:user) }
  let(:email) { user.email }

  before { visit resend_confirmation_path }

  describe 'when I enter my email address correctly' do
    let(:expected_message) { t('confirmations.create.success') }

    it 'redirects to the home page and show the success message' do
      fill_in t('confirmations.new.label.email'), with: email

      click_button t('confirmations.new.button.submit')

      expect(page).to have_content expected_message
    end
  end

  describe 'when the user is not found' do
    let(:email) { Faker::Internet.email }
    let(:expected_error) { t('confirmations.create.error') }

    it 'shows the error message' do
      fill_in t('confirmations.new.label.email'), with: email

      click_button t('confirmations.new.button.submit')

      expect(page).to have_current_path resend_confirmation_path
      expect(page).to have_content expected_error
    end
  end
end
