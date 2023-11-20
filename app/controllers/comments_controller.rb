class CommentsController < ApplicationController

    def create
        comment = current_user.comments.build(comment_params)
      if comment.save
        flash[:success] = t('defaults.flash_message.created', item: "コメント" )
        #/boards/:idのような形で、該当するボードの詳細ページへのパスを生成します。
        redirect_to board_path(comment.board)
      else
        flash[:danger] = t('defaults.flash_message.not_created', item: "コメント")
        redirect_to board_path(comment.board), status: :unprocessable_entity
      end
    end

private

    def comment_params
        params.require(:comment).permit(:body).merge(board_id: params[:board_id])
    end
end
