class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # メッセージ情報取得
    @message = Message.new(talk_id:data['talk_id'], user_id:data['user_id'], content:data['message'])
    # DBへメッセージ登録
    if @message.save
      #binding.pry
      # クライアントへブロードキャスト
      ActionCable.server.broadcast 'room_channel', data['message'] + ':::' + data['image'] + ':::' + data['name'] + ':::' + data['user_id']
    end

  end
end
