class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[edit show update destroy]

  def index
    @q = Board.includes(:user).ransack(params[:q])
    @boards = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @board.update(board_params)
      flash[:success] = t('.update_board')
      redirect_to admin_board_path(@board)
    else
      flash.now[:danger] = t('.no_update_board')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    flash[:success] = t('.destroy_board')
    redirect_to admin_boards_path, status: :see_other
  end

  private

  # params.require(:〇〇)permit(:〇〇)は、情報取得する.必要(モデル).許可(カラム)
  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
