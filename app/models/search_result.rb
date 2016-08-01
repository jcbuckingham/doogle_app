class SearchResult < ApplicationRecord
  has_many :definitions, dependent: :destroy
  VALID_REGEX = /[a-zA-Z]+/
  validates :user_input, format: { with: VALID_REGEX }
end


