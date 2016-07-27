class SearchResult < ApplicationRecord
  has_many :definitions, dependent: :destroy
  VALID_REGEX = /[a-zA-Z]+/
  validates :user_input, format: { with: VALID_REGEX }
end


=begin

  def parse_result(doc)
    dts = doc.xpath("//dt").map

    dts.each do |node|
      node.each do |child|
        child = ""
      end
    end

    #dt_nodeset.each do |node|
    #  if /<vi>/.match(node)

    return dts
  end


=end

