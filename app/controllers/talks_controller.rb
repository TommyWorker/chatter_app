class TalksController < ApplicationController

  def index
    # ログイン者がメンバーとなっているメンバー情報取得
    targets = Member.where(user_id: @current_user.id).select(:talk_id)
    # ログイン者がメンバーとなっているトーク情報取得
    @talks = Talk.where(id: targets).all.order(created_at: :desc)

  end

  def room
    # TalkID取得
    @talk_id = params[:talk_id]
    # MessageとUserを結合して、メッセージ情報取得（作成日時降順）
    @messages = Message.joins(:User).where(talk_id:params[:talk_id]).order(created_at: :desc).select("messages.*,users.name,users.image_name")

  end

end
