require 'rspec/rails'

RSpec.describe SearchResultController, type: :controller do

  describe 'ajax' do
    let(:random_str) { (0...8).map { (65 + rand(26)).chr }.join }

    it "has a 200 status code", network: true do
      post :create, xhr: true, params: {search_result: {user_input: random_str}}
      expect(response.code).to eq("200")
    end
  end
end