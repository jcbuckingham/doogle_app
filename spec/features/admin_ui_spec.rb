require 'rspec/rails'
require 'capybara/rspec'
require 'active_support/core_ext/kernel/reporting'
require 'spec_helper'
require 'capybara/rails'

RSpec.describe SearchResultController, :js => true, type: :feature do

  describe 'routing' do
    it 'gets rails admin path' do
      visit rails_admin_path
      expect(page).to have_content("Site Administration")
      expect(current_path).to eq(rails_admin_path)
    end
  end
end
