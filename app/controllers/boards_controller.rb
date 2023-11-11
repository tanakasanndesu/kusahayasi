class BoardsController < ApplicationController
  def index
    # Boardモデルの全てのインスタンスを取得
    # 各Boardに関連するUserモデルの情報をプリロード
    # 作成日時(created_at)の降順で並べ替え
    @boards = Board.all.includes(:user)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:success] = t('.create_board')
      redirect_to boards_path
    else
      flash[:danger] = t('.no_create_board')
      render :new, status: :unprocessable_entity
    end
  end

  private

  # params.require(:〇〇)permit(:〇〇)は、情報取得する.必要(モデル).許可(カラム)

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
