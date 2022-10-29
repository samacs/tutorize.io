require 'rails_helper'

RSpec.describe UserMailer do
  describe '#confirmation_email' do
    describe 'when a user is created' do
      it 'sends the confirmation email' do
        expect { create(:user) }.to have_enqueued_job.on_queue('mailers').exactly(:twice)
      end

      it 'has the right content' do
        I18n.with_options(scope: 'user_mailer.confirmation_email') do |i18n|
          user = create(:user)
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
end
