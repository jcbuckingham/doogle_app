require_relative '/home/shazam/RubymineProjects/doogle_jb2/app/controllers/main_page_controller'
#require_relative '../app/helpers/main_page_helper'
require 'rspec/rails'
require 'capybara/rspec'

RSpec.describe MainPageController, type: :controller do

  describe 'routing' do
    it 'gets root path' do
      expect(:get => root_path).to route_to(:controller=>"search_result", :action=>"index")
    end

    it 'posts on search path' do
      expect(:post => "/").to route_to(:controller=>"search_result", :action=>"index")
    end

    it 'posts on create path' do
      expect(:post => "/create").to route_to(:controller=>"search_result", :action=>"create")
    end
  end

end
