require 'rails_helper'

RSpec.describe Users::CreateAction, type: :action do
  subject(:result) { described_class.execute(context) }

  let(:context) { { user: } }

  describe 'when a non persisted user is passed' do
    context 'when the user is not valid' do
      let(:user) { build(:user, password_confirmation: 'wrong-password-confirmation') }

      it { is_expected.to be_failure }

      it 'contains the validation errors' do
        expect(result.message.full_messages).to match ["Password confirmation doesn't match Password"]
      end
    end

    context 'when the user is valid' do
      let(:user) { build(:user) }

      it { is_expected.to be_success }
    end
  end
end
