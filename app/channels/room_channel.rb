class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)

    @message = Message.new(talk_id:data['talk_id'], user_id:data['user_id'], content:data['message'])
    if @message.save
      #binding.pry
      ActionCable.server.broadcast 'room_channel', data['message'] + ':::' + data['image'] + ':::' + data['name'] + ':::' + data['user_id'] + ':::' + @message.updated_at.in_time_zone('Tokyo').strftime("%m月 %d日 %H:%M")
    end

  end
end
