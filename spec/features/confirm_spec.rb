require 'rails_helper'

RSpec.describe 'Confirm' do
  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:confirmation_token) { user.confirmation_token }

  describe 'when no parameters are given' do
    it 'redirects back to the home page' do
      visit confirm_path

      expect(page).to have_current_path root_path
    end
  end

  describe 'when the user is found' do
    before { user.add_role(user.sign_up_role) }

    it 'confirms the user and is redirected to the sign in page' do
      visit confirm_path(email:, confirmation_token:)

      expect(page).to have_current_path sign_in_path
    end
  end

  describe 'when the user is not found' do
    shared_examples_for 'user not found' do
      it 'redirects back to the home page and shows an error message' do
        visit confirm_path(email:, confirmation_token:)

        expect(page).to have_current_path root_path
        expect(page).to have_content expected_error_message
      end
    end

    context 'when the email is wrong' do
      let(:expected_error_message) { t('users.confirm.error') }
      let(:email) { 'wrong@email.com' }

      it_behaves_like 'user not found'
    end

    context 'when the confirmation token is wrong' do
      let(:expected_error_message) { t('users.confirm.error') }
      let(:confirmation_token) { 'wrong_confirmation_token' }

      it_behaves_like 'user not found'
    end
  end
end
