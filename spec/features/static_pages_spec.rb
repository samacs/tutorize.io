require 'rails_helper'

RSpec.describe 'Static pages' do
  describe 'Home page' do
    context 'when the user is not logged in' do
      it 'shows the welcome message' do
        visit root_path

        expect(page).to have_content(/welcome/i)
      end
    end
  end

  describe 'Not found' do
    context 'when a page is not found' do
      it 'shows the Not Found page' do
        visit static_pages_path(page: 'not-existent')

        expect(page).to have_content(/not found/i)
      end
    end
  end
end
