require 'rails_helper'

RSpec.describe 'Reset password' do
  let(:user) { create(:user, :confirmed) }

  before { visit reset_password_path }

  describe 'when the user enters the email' do
    before { reset_password(email) }

    context 'when user exists' do
      let(:email) { user.email }

      it 'redirects to the sign in page and shows the success message' do
        expect(page).to have_current_path sign_in_path
        expect(page).to have_content t('password_resets.create.success')
      end
    end

    context 'when user does not exist' do
      let(:email) { 'non-existent@email.com' }

      it 'shows the error message' do
        expect(page).to have_current_path reset_password_path
        expect(page).to have_content t('password_resets.create.error')
      end
    end
  end
end
