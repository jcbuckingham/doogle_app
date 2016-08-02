require 'rspec/rails'

RSpec.describe SearchResultController, type: :controller do

  describe 'ajax' do
    let(:random_str) { (0...8).map { (65 + rand(26)).chr }.join }

    it "has a 200 status code", network: true do
      xhr :post, :create, xhr: true, params: {search_result: {user_input: random_str}}
      expect(response.code).to eq("200")
    end
  end

  describe 'fetch data' do
    let(:random_str) { (0...8).map { (65 + rand(26)).chr }.join }

    let(:random_noun) { "zipper" }

    before do
      temp = SearchResult.find_by(user_input: random_noun)
      if temp
        SearchResult.destroy(temp.id)
      end
    end

    let!(:old_word) { xhr :post, :create, params: {search_result: {user_input: "duplicate"}} }

    it "accepts good input", network: true do
      expect {
        xhr :post, :create, params: {search_result: {user_input: random_str}}
      }.to change { SearchResult.count }
    end

    it "rejects bad input" do
      expect {
        xhr :post, :create, params: {search_result: {user_input: "bad input"}}
      }.to_not change { SearchResult.count }

      expect {
        xhr :post, :create, params: {search_result: {user_input: "*input"}}
      }.to_not change { SearchResult.count }

      expect {
        xhr :post, :create, params: {search_result: {user_input: ""}}
      }.to_not change { SearchResult.count }

      expect {
        xhr :post, :create, params: {search_result: {user_input: nil}}
      }.to_not change { SearchResult.count }
    end

    it "rejects duplicate input" do
      expect {
        xhr :post, :create, params: {search_result: {user_input: "duplicate"}}
      }.to_not change { SearchResult.count }
    end

    context 'when the user input is a new word', network: false do
      let(:api_endpoint) { "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/hat?key=64f621d1-a5ae-4337-8f71-02924c6ce747" }
      before do
        temp = SearchResult.find_by(user_input: random_noun)
        if temp
          SearchResult.destroy(temp.id)
        end
      end

      it 'calls the dictionary API' do
        api_response = Nokogiri::HTML(open(api_endpoint))
        expect(api_response).to be_an_instance_of(Nokogiri::HTML::Document)
        expect(response.code).to eq("200")
        expect(api_response.inspect.scan("opposing").size).to eq(1)
      end

      it 'creates the new definitions from the API call' do
        expect {
          xhr :post, :create, params: {search_result: {user_input: random_noun}}
        }.to change { Definition.count }
      end
    end

    context 'when the word already exists' do
      it "pulls old data from the database" do
        expect { xhr :post, :create, params: {search_result: {user_input: old_word}} }.to_not change { Definition.count }
      end
    end
  end
end