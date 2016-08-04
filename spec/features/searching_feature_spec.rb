require 'rspec/rails'
require 'capybara/rspec'
require 'active_support/core_ext/kernel/reporting'
require 'spec_helper'
require 'capybara/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'searching_ui', :js => true, :type => :feature do

  describe 'opening web page' do
    it 'loads capybara in the test' do
      visit 'https://www.google.com/'
      expect(page).to have_content
    end
  end

  describe 'searching' do
    let!(:test_word) {"test"}
    let!(:brand_new_word) {'rabbit'}
    let!(:another_word) {'another'}
    before do
      Capybara.ignore_hidden_elements = false
      visit root_path
      element = page.find_field("user_input")
      element.set(test_word)
      page.find_button("Search")
      click_button "Search"

      temp = SearchResult.find_by(user_input: brand_new_word)
      if temp
        SearchResult.destroy(temp.id)
      end

      temp = SearchResult.find_by(user_input: another_word)
      if temp
        SearchResult.destroy(temp.id)
      end

      sleep(2.5)

    end

    context 'user enters input with new word', format: :js do

      it 'enters user data and finds button' do
        Capybara.ignore_hidden_elements = false
        visit root_path
        element = page.find_field("user_input")
        element.set(another_word)
        page.find_button("Search")
        click_button "Search"
      end

      it 'creates a SearchResult obj' do
        Capybara.ignore_hidden_elements = false
        temp = SearchResult.find_by(user_input: test_word)
        if temp
          SearchResult.destroy(temp.id)
        end

        visit root_path
        element = page.find_field("user_input")
        element.set(brand_new_word)
        expect {
          page.find_button("Search")
          click_button "Search"
          sleep(2.5)
        }.to change { SearchResult.count }.by(1)
      end
    end

    context 'user enters input with old word' do
      it 'creates no new objects' do
        Capybara.ignore_hidden_elements = false
        visit root_path
        element = page.find_field("user_input")
        element.set(test_word)

        expect {
          page.find_button("Search")
          click_button "Search"
          sleep(2.5)
        }.to_not change { SearchResult.count }
      end
    end

    context 'user enters invalid input' do
      it 'displays error message' do
        Capybara.ignore_hidden_elements = true
        visit root_path
        element = page.find_field("user_input")
        element.set("this doesn't work")
        page.find_button("Search")
        click_button "Search"
        sleep(2.5)
        expect(page).to have_content('No definitions were found.')
      end

      it 'does not create a database entry' do
        Capybara.ignore_hidden_elements = true
        visit root_path
        element = page.find_field("user_input")
        element.set("this doesn't work either")
        page.find_button("Search")
        expect {
          click_button "Search"
          sleep(2.5)
        }.to_not change { SearchResult.count }
      end
    end

    it 'displays definitions' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      element = page.find_field("user_input")
      element.set("elephant")
      page.find_button("Search")
      click_button "Search"
      sleep(2.5)
      expect(find('ul')).to have_selector('li', count: 15)
    end

    it 'removes XML tags from displayed result' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      element = page.find_field("user_input")
      element.set(test_word)
      page.find_button("Search")
      click_button "Search"
      sleep(2.5)
      list = find('ul').all('li')
      list.each do |li|
        expect(li.text).to_not match('<')
        expect(li.text).to_not match('>')
      end
    end

    it 'does not display extra data below result list items' do
      temp = SearchResult.find_by(user_input: "umbrella")
      if temp
        SearchResult.destroy(temp.id)
      end
      Capybara.ignore_hidden_elements = true
      visit root_path
      element = page.find_field("user_input")
      element.set("umbrella")
      page.find_button("Search")
      click_button "Search"
      sleep(2.5)
      expect(page).to have_no_content('Definition id')
    end
  end
end
