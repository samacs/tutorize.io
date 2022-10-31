require 'rails_helper'

RSpec.describe UserMailer do
  describe '#confirmation_email' do
    describe 'when a user is created' do
      it 'sends the confirmation email' do
        Sidekiq::Testing.inline! { expect { create(:user) }.to have_enqueued_job.on_queue('mailers').exactly(:once) }
      end

      it 'has the right content' do
        user = create(:user)
        I18n.with_options(scope: 'user_mailer.confirmation_email') do |i18n|
          link = link_to i18n.t('link.confirm'),
                         confirm_url(email: user.email, confirmation_token: user.confirmation_token)
          email_subject = i18n.t('subject', user_name: user.first_name)
          email_heading = i18n.t('heading', user_name: user.first_name)
          mailer = described_class.with(user:).confirmation_email
          content = mailer.body.encoded

          expect(mailer.subject).to eq email_subject
          expect(mailer.to).to eq [user.email]
          expect(mailer.from).to eq [Setting.default_email_address]
          expect(content).to include link
          expect(content).to match email_heading
        end
      end
    end

    shared_examples_for 'welcome email' do
      it 'sends the welcome email with the right content' do
        I18n.with_options(scope: "user_mailer.#{user.sign_up_role}_welcome_email") do |i18n|
          email_subject = i18n.t('subject', user_name: user.first_name)
          email_heading = i18n.t('heading', user_name: user.first_name)
          mailer = described_class.with(user:).send("#{user.sign_up_role}_welcome_email")
          content = mailer.body.encoded

          expect(mailer.subject).to eq email_subject
          expect(mailer.to).to eq [user.email]
          expect(mailer.from).to eq [Setting.default_email_address]
          expect(content).to match email_heading
        end
      end
    end

    describe 'when a student is created' do
      let(:user) { create(:student) }

      it_behaves_like 'welcome email'
    end

    describe 'when a teacher is created' do
      let(:user) { create(:teacher) }

      it_behaves_like 'welcome email'
    end
  end

  shared_examples_for 'role based email' do |role_name|
    it 'sends the role based welcome email' do
      user = create(role_name)
      Sidekiq::Testing.inline! { expect { user.confirm! }.to have_enqueued_job.on_queue('mailers').exactly(:once) }
    end
  end

  describe 'when a student is created' do
    it_behaves_like 'role based email', :student
  end

  describe 'when a teacher is created' do
    it_behaves_like 'role based email', :teacher
  end

  describe '#password_reset_email' do
    let(:user) { create(:user) }

    it 'has the right content' do
      user = create(:user, :confirmed)
      user.generate_password_reset_token!
      email = user.email
      password_reset_token = user.password_reset_token
      I18n.with_options(scope: 'user_mailer.password_reset_email') do |i18n|
        link = link_to i18n.t('link.change_password'),
                       change_password_url(email:, password_reset_token:)
        email_subject = i18n.t('subject', user_name: user.first_name)
        email_heading = i18n.t('heading', user_name: user.first_name)
        email_instructions = i18n.t('instructions')
        mailer = described_class.with(user:).password_reset_email
        content = mailer.body.encoded

        expect(mailer.subject).to eq email_subject
        expect(mailer.to).to eq [email]
        expect(mailer.from).to eq [Setting.default_email_address]
        expect(content).to include link
        expect(content).to match email_heading
        expect(content).to match email_instructions
      end
    end
  end
end
