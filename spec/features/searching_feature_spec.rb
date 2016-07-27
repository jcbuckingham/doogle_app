require_relative '/home/shazam/RubymineProjects/doogle_jb2/app/controllers/main_page_controller'
require 'rspec/rails'
require 'capybara/rspec'
require 'active_support/core_ext/kernel/reporting'

RSpec.describe 'searching_ui', :type => :feature do

  describe 'searching', network: true do
    let(:random_str) { (0...8).map { (65 + rand(26)).chr }.join }

    it 'enters user data and finds button' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      save_and_open_page
      element = page.find_field("user_input")
      element.set(random_str)
      page.find_button("Search")
      click_button "Search"
    end

    context 'user enters input with new word' do
      it 'creates a SearchResult obj' do
        Capybara.ignore_hidden_elements = false
        visit root_path
        save_and_open_page
        element = page.find_field("user_input")
        element.set(random_str)

        expect {
          page.find_button("Search")
          click_button "Search"
        }.to change { SearchResult.count }.by(1)
      end
    end

    context 'user enters input with old word' do
      it 'creates no new objects' do
        Capybara.ignore_hidden_elements = false
        visit root_path
        save_and_open_page
        element = page.find_field("user_input")
        element.set("duplicate")

        expect {
          page.find_button("Search")
          click_button "Search"
        }.to_not change { SearchResult.count }
      end
    end

    it 'displays definitions' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      save_and_open_page
      element = page.find_field("user_input")
      element.set("duplicate")
      page.find_button("Search")
      click_button "Search"
      expect(find('ul')).to have_selector('li', count: 12)
    end

    it 'removes XML tags from displayed result' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      save_and_open_page
      element = page.find_field("user_input")
      element.set("duplicate")
      page.find_button("Search")
      click_button "Search"
      list = find('ul').all('li')
      list.each do |li|
        expect(li.text).to_not match('<')
        expect(li.text).to_not match('>')
      end
    end
  end
end
