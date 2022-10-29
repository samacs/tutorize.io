require 'rails_helper'

RSpec.describe ServiceBase, type: :service do
  describe 'when #actions is not overridden' do
    let(:expected_error) { 'Please override this method and include your service actions' }

    it 'raise an error' do
      expect { described_class.call({}) }.to raise_error expected_error
    end
  end
end
