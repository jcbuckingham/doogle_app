class Definition < ApplicationRecord
  belongs_to :search_result
  default_scope -> { order(created_at: :asc) }
  validates :content, presence: true
end
