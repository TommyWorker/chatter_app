App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    const messages = document.getElementById('messages')
    var msginfo = data.split(':::')
    user_id = document.getElementById('h_user_id')
    if (msginfo[3] == user_id.value){
      messages.innerHTML =
                    '<div class="msg">' +
                      '<figure class="msg-img-right">' +
                       '<img src="/user_images/' + msginfo[1] + '">' +
                       '<figcaption class="msg-img-description">' + msginfo[2] +
                       '</figcaption>' +
                      '</figure>' +
                      '<div class="msg-text-left">' +
                       '<p class="msg-text">' + msginfo[0].replace(/\n/g, '<br>') + '</p>' +
                       '<p class="msg-timestamp">' + msginfo[4] + '</p>' +
                      '</div>' +
                    '</div>'
                     + messages.innerHTML
    }else{
      messages.innerHTML =
                    '<div class="msg">' +
                      '<figure class="msg-img-left">' +
                       '<img src="/user_images/' + msginfo[1] + '">' +
                       '<figcaption class="msg-img-description">' + msginfo[2] +
                       '</figcaption>' +
                      '</figure>' +
                      '<div class="msg-text-right">' +
                       '<p class="msg-text">' + msginfo[0].replace(/\n/g, '<br>') + '</p>' +
                       '<p class="msg-timestamp">' + msginfo[4] + '</p>' +
                      '</div>' +
                    '</div>'
                     + messages.innerHTML
    }
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function(content, talk_id, user_id, image, name) {
    return this.perform('speak', {message: content, talk_id: talk_id, user_id: user_id, image: image, name: name});
  }
});

document.addEventListener('DOMContentLoaded', function(){
    const content = document.getElementById('chat-input')
    const talk_id = document.getElementById('h_talk_id')
    const user_id = document.getElementById('h_user_id')
    const user_image = document.getElementById('h_user_image')
    const user_name  = document.getElementById('h_user_name')
    const button = document.getElementById('msg_submit')
    button.addEventListener('click', function(){
    // 入力チェック
    if (content.value == ''){
      alert('メッセージを入力してください。');
      return false;
    }else{
    if (content.value.indexOf(':::') > 0){
        alert(':::と続けて入力することはできません。');
        return false;
      }
    }
    App.room.speak(content.value, talk_id.value, user_id.value, user_image.value, user_name.value)
    content.value = ""
  })
})
