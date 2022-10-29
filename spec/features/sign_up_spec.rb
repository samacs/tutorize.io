require 'rails_helper'

RSpec.describe 'Sign up' do
  subject { page }

  before { visit sign_up_path }

  its(:current_path) { is_expected.to eq sign_up_path }

  describe 'fields' do
    let(:role_options) do
      [t('users.form.option.i_am_a_teacher'), t('users.form.option.i_am_a_student')]
    end

    it { is_expected.to have_content t('users.new.heading') }
    it { is_expected.to have_button t('users.form.button.submit') }
    it { is_expected.to have_link t('users.form.link.sign_in') }
    it { is_expected.to have_link t('users.form.link.resend_confirmation') }
    it { is_expected.to have_select t('users.form.label.teacher_or_student'), options: role_options }

    it {
      expect(page).to have_link t('users.form.link.terms_of_service',
                                  href: static_pages_path(page: 'terms-of-service'))
    }

    I18n.with_options(scope: 'activerecord.attributes.user') do |i18n|
      it { is_expected.to have_field i18n.t('first_name') }
      it { is_expected.to have_field i18n.t('last_name') }
      it { is_expected.to have_field i18n.t('email') }
      it { is_expected.to have_field i18n.t('password') }
      it { is_expected.to have_field i18n.t('password_confirmation') }
    end
  end

  describe 'form submission' do
    context 'when validation fails' do
      it 'displays the validation error messages' do
        expect { click_button t('users.form.button.submit') }.not_to change(User, :count)

        expect(page).to have_current_path sign_up_path, ignore_query: true

        expect(page).to have_content t('shared.form_errors.heading')
        expect(page).to have_content "First name can't be blank"
        expect(page).to have_content "Last name can't be blank"
        expect(page).to have_content "Email address can't be blank"
        expect(page).to have_content 'Email address is invalid'
        expect(page).to have_content 'Terms of Service must be accepted'
        expect(page).to have_content "Password can't be blank"
      end
    end

    context 'when validation passes' do
      it 'displays the success message', js: true do
        user_attributes = attributes_for(:user)
        fill_in_sign_up_form(user_attributes, submit: true)

        # TODO: This is not working with Turbo, so testing the user at the bottom
        # expect { click_button t('users.form.button.submit') }.to change(User, :count).by(1)

        expect(page).to have_current_path sign_up_path
        expect(page).to have_content t('users.create.heading', user_name: user_attributes[:first_name])
        expect(page).to have_link t('users.create.link.sign_in'), href: sign_in_path

        user = User.find_by(email: user_attributes[:email])

        expect(user).not_to be_nil
        expect(user.first_name).to eq user_attributes[:first_name]
        expect(user.last_name).to eq user_attributes[:last_name]
        expect(user.terms_of_service).to be true
        expect(user.needs_confirmation?).to be true
        # expect(user.confirmation_token_sent_at).not_to be_nil
      end
    end
  end
end
