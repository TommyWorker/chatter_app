class TalksController < ApplicationController

  def index

    targets = Member.where(user_id: @current_user.id).select(:talk_id)
    @talks = Talk.where(id: targets).all.order(created_at: :desc)

  end

  def room

    @talk_id = params[:talk_id]
    @messages = Message.joins(:User).where(talk_id:params[:talk_id]).order(created_at: :desc).select("messages.*,users.name,users.image_name")

  end

end
