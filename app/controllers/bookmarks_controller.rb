class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    flash[:success] = t('.create_bookmark')
    redirect_to boards_path
  end

  def destroy
    board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(board)
    flash[:danger] = t('.destroy_bookmark')
    redirect_to boards_path, status: :see_other
  end
end
