require 'rails_helper'

RSpec.shared_examples_for Confirmable do
  it { is_expected.to be <= Confirmable }

  describe '#skip_confirmation!' do
    subject(:user) { create(:user) }

    before { user.skip_confirmation! }

    it { is_expected.to be_valid }
    its(:confirmation_token_sent_at) { is_expected.not_to be_nil }
    its(:confirmed_at) { is_expected.not_to be_nil }
    its(:confirmed?) { is_expected.to be true }
    its(:needs_confirmation?) { is_expected.to be false }
    its(:skip_confirmation?) { is_expected.to be true }
  end
end
