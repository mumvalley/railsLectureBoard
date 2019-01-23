# コントローラーではモデルのクラスを使うことができる
# binding.pryでデバッグ
# docker attach コンテナ名でアタッチ exit:一時停止, ctr p q: アタッチから抜ける
class BoardsController < ApplicationController
  before_action :set_target_board, only: %i(show edit update destroy)
  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end

  def new
    # Boardモデルのオブジェクト作成しインスタンス変数に代入
    @board = Board.new(flash[:board])
  end

  def create
    # postされたデータをparamsで受け取る
    board = Board.new(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました。"
      redirect_to board
    else
      redirect_back fallback_location: root_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  # コメントと紐づける
  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
  end

  def update
    # <!-- updateはviewページないため普通の変数に代入 -->
    if @board.update(board_params)
      redirect_to @board
    else
      redirect_to :back, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: { notice: "[#{@board.title}]の掲示板が削除されました。" }
  end

  private
  # ストロングパラメーター 受け取りを制限する
    def board_params
      params.require(:board).permit(:name, :title, :body, tag_ids: [])
    end

    def set_target_board
      @board = Board.find(params[:id])
    end

end
