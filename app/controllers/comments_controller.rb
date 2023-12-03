class CommentsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def edit; end

  def update; end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @board = @comment.board
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
