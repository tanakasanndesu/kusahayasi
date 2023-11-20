class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :body, presence: true, length: { maximum: 65535 }

  scope :first_comment, -> { order(created_at: :desc) }
  
end
