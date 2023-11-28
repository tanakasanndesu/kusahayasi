class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
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
      flash[:success] = t('defaults.flash_message.created', item: '掲示板')
      redirect_to boards_path
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: '掲示板')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    # @board に紐づくコメントデータを取得し、各コメントに紐づくユーザーデータも同時に取得する
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @board.update(board_params)
      flash[:success] = t('.update_boards')
      redirect_to board_path(@board)
    else
      flash.now[:danger] = t('.no_update_boards')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, status: :see_other
    flash[:success] = t('.destroy_boards')
  end

  def bookmarks
    @bookmark_boards = current_user.bookmarks_boards.includes(:user).order(created_at: :desc)
  end

  private

  # params.require(:〇〇)permit(:〇〇)は、情報取得する.必要(モデル).許可(カラム)

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
