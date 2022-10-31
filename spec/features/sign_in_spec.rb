require 'rails_helper'

RSpec.describe 'Sign in' do
  subject { page }

  before { visit sign_in_path }

  its(:current_path) { is_expected.to eq sign_in_path }

  describe 'fields' do
    it { is_expected.to have_content t('sessions.new.heading') }
    it { is_expected.to have_button t('sessions.form.button.submit') }
    it { is_expected.to have_link t('sessions.form.link.sign_up') }
    it { is_expected.to have_link t('sessions.form.link.reset_password') }

    I18n.with_options(scope: 'activerecord.attributes.user') do |i18n|
      it { is_expected.to have_field i18n.t('email') }
      it { is_expected.to have_field i18n.t('password') }
    end
  end

  describe 'form submission' do
    context 'when user is confirmed and the credentials are correct' do
      let(:user) { create(:user, :confirmed) }

      it 'redirects the user to the home page' do
        sign_in(email: user.email, password: user.password)

        expect(page).to have_current_path root_path
      end
    end

    context 'when validation fails' do
      it 'displays the validation error messages' do
        click_button t('sessions.form.button.submit')

        expect(page).to have_current_path sign_in_path
      end
    end

    context 'when the user is not found' do
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Internet.password }
      let(:user) { create(:user, :confirmed, email:, password:) }
      let(:expected_error) { t('sessions.create.credentials_error') }

      it 'displays the wrong credentials error' do
        sign_in(email: 'wrong@email.com', password:)

        expect(page).to have_current_path sign_in_path
        expect(page).to have_content expected_error
      end
    end

    context 'when the user has not been confirmed' do
      let(:user) { create(:user) }
      let(:email) { user.email }
      let(:password) { user.password }
      let(:expected_error) { t('sessions.create.confirmation_error') }

      it 'displays the confirmation error' do
        sign_in(email: user.email, password: user.password)

        expect(page).to have_current_path sign_in_path
        expect(page).to have_content expected_error
      end
    end

    context 'when the password is wrong' do
      let(:user) { create(:user, :confirmed) }
      let(:email) { user.email }
      let(:expected_error) { t('sessions.create.credentials_error') }

      it 'displays the credentials error' do
        sign_in(email:, password: 'wrong_password')

        expect(page).to have_current_path sign_in_path
        expect(page).to have_content expected_error
      end
    end

    context 'when the user is resetting password' do
      let(:user) { create(:user, :confirmed, :resetting_password) }
      let(:email) { user.email }
      let(:password) { user.password }
      let(:expected_error) { t('sessions.create.resetting_password_error') }

      it 'displays the resetting password error' do
        sign_in(email:, password:)

        expect(page).to have_current_path sign_in_path
        expect(page).to have_content expected_error
      end
    end
  end

  context 'when the user is signed in' do
    let(:user) { create(:user, :confirmed) }
    let(:email) { user.email }
    let(:password) { user.password }

    before { sign_in(email:, password:) }

    context 'when the user tries to access the sign up page' do
      before { visit sign_up_path }

      it 'redirects back to the previous page or the root page' do
        expect(page).to have_current_path authenticated_root_path
      end
    end

    context 'when the user tries to access the sign in page' do
      before { visit sign_in_path }

      it 'redirects back to the previous page or the root page' do
        expect(page).to have_current_path authenticated_root_path
      end
    end
  end
end
