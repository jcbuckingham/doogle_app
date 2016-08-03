require 'rspec/rails'

RSpec.describe SearchResultController, type: :controller do

  describe 'routing' do
    it 'gets root path' do
      expect(:get => root_path).to route_to(:controller=>"search_result", :action=>"index")
    end

    it 'posts on create path' do
      expect(:post => "/create").to route_to(:controller=>"search_result", :action=>"index")
    end
  end

end
