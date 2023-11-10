class BoardsController < ApplicationController
  def index
    # Boardモデルの全てのインスタンスを取得
    # 各Boardに関連するUserモデルの情報をプリロード
    # 作成日時(created_at)の降順で並べ替え
    @boards = Board.all.includes(:user)
  end
end
