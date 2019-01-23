# コントローラーではモデルのクラスを使うことができる
# binding.pryでデバッグ
# docker attach コンテナ名でアタッチ exit:一時停止, ctr p q: アタッチから抜ける

class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.board
    else
      redirect_back fallback_location: root_path, flash: {
        comment: comment,
        error_messages: comment.errors.full_message
      }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.board, flash: { notice: 'コメントが削除されました' }
  end

  private
  def comment_params
    params.require(:comment).permit(:name, :comment, :board_id)
  end
end
