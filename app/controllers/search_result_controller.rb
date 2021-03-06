require 'open-uri'

class SearchResultController < ApplicationController
  def new
    @result = SearchResult.new
    @definition_list = []
  end

  def index
  end

  def show
  end

  def create
    params_result = SearchResult.new(search_params)
    return unless clean_result(params_result.user_input)

    db_result = SearchResult.find_by(user_input: params_result.user_input)

    unless db_result
      db_result = new_search_result(params_result.user_input)
    end

    @result = db_result
    @definition_list = Definition.where(search_result: @result)

    respond_to do |format|
      format.js
    end
  end

  private

  def search_params
    params.require(:search_result).permit(:user_input)
  end

  #returns true if user input contains only ascii letters
  def clean_result(input)
    if input.nil? || input.empty?
      return false
    end
    return /^[a-zA-Z]*$/.match(input)
  end

  def new_search_result(new_word)
    new_result = SearchResult.create(user_input: new_word)
    parse_result_into_definitions(contact_api(new_word), new_result)
    return new_result
  end

  def contact_api(word)
    api_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/"
    api_key = "?key=64f621d1-a5ae-4337-8f71-02924c6ce747"

    return open(api_url + word + api_key)
  end

  def parse_result_into_definitions(doc, new_result)
    doc = Nokogiri::XML(doc)
    doc.xpath('//sx', '//vi', '//un', '//dx').each do |tag|
      tag.remove
    end

    dts = doc.xpath("//dt").map(&:text)

    dts.each do |node|
      node.strip!
      unless node.to_s == ":"
        if node.chars.first == ":"
          node[0] = ''
        end
        if node.chars.last == ":"
          node[-1] = ''
        end

        new_result.definitions.create(content: node.to_s)
      end
    end
  end
end
