class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board

  mount_uploader :avatar, AvatarUploader

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }

  # allow_nilこのフィールドが nil であることを許可する
  validates :reset_password_token, uniqueness: true, allow_nil: true

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  # お気に入り追加
  # <<で引数で渡した掲示板の情報がbookmark_boardsに入っている
  def bookmark(board)
    bookmarks_boards << board
    # bookmarks.create(board_id: board.id)と同じような処理になります
  end

  def unbookmark(board)
    bookmarks_boards.destroy(board)
    # bookmarks.destroy(bookmarks.find_by(board_id: board.id))と同じような処理になります
  end

  # お気に入り登録しているか判定するメソッド
  def bookmark?(board)
    bookmarks_boards.include?(board)
  end
end
