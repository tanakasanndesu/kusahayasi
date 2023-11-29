class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :board

  # presence: trueは省略
  validates :user_id, uniqueness: { scope: :board_id }
end
