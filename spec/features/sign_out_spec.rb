require 'rails_helper'

RSpec.describe 'Sign out' do
  describe 'when a user is signed in' do
    let(:user) { create(:user, :confirmed) }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:sign_out_link) { t('sign_out_link') }

    before { sign_in(email:, password:) }

    it 'clicking the sign out button terminates the current session' do
      expect(page).to have_current_path authenticated_root_path
      expect(page).to have_link sign_out_link

      click_link sign_out_link

      expect(page).to have_current_path root_path
      expect(page).not_to have_link sign_out_link
    end
  end
end
