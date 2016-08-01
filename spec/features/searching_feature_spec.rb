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
    let(:elephant) {'elephant'}
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

    end
    # let(:random_str) { (0...8).map { (65 + rand(26)).chr }.join }
    # let(:random_noun) do
    #   arr = ['test', 'sky', 'income', 'support', 'scale', 'orange', 'base', 'writing', 'ship', 'pail', 'bead', 'rest', 'zinc', 'shade', 'arm', 'branch',
    #          'metal', 'brick', 'basin', 'wrist', 'key', 'pocket', 'trains', 'rain', 'spade', 'hands', 'group', 'substance', 'structure', 'trucks', 'thread',
    #          'book', 'seashore', 'boat', 'zipper', 'baseball', 'top', 'cloth', 'actor', 'trouble', 'watch', 'night', 'volcano', 'class', 'number', 'tray',
    #          'representative', 'milk', 'goat', 'egg', 'dinosaur', 'elbow', 'scissors', 'feet', 'farm', 'strawberry', 'computer', 'student', 'paper', 'think',
    #          'finger', 'hand', 'juice', 'horse', 'ring', 'table', 'couch', 'kick', 'raft', 'organ', 'screen', 'button', 'water', 'bottle', 'phone', 'pants']
    #   arr.sample
    # end

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
        # temp = SearchResult.find_by(user_input: test_word)
        # if temp
        #   SearchResult.destroy(temp.id)
        # end

        visit root_path
        element = page.find_field("user_input")
        element.set(brand_new_word)
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
        element = page.find_field("user_input")
        element.set(test_word)

        expect {
          page.find_button("Search")
          click_button "Search"
        }.to_not change { SearchResult.count }
      end
    end

    it 'displays definitions' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      element = page.find_field("user_input")
      element.set(elephant)
      page.find_button("Search")
      click_button "Search"
      expect(find('ul')).to have_selector('li', count: 15)
    end

    it 'removes XML tags from displayed result' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      element = page.find_field("user_input")
      element.set(test_word)
      page.find_button("Search")
      click_button "Search"
      list = find('ul').all('li')
      list.each do |li|
        expect(li.text).to_not match('<')
        expect(li.text).to_not match('>')
      end
    end

    it 'does not display extra data below result list items' do
      Capybara.ignore_hidden_elements = false
      visit root_path
      element = page.find_field("user_input")
      element.set(elephant)
      page.find_button("Search")
      click_button "Search"
      expect(page).to have_no_content('Definition id')
    end
  end
end
