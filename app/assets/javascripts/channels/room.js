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
    // [0]：メッセージ　[1]：プロファイル画像ファイル名　[2]：ユーザ名　[3]：ユーザID
    var msginfo = data.split(':::')
    // 画面を開いているユーザ情報取得
    user_id = document.getElementById('h_user_id')
    // 取得メッセージが自分のものであれば右側に表示
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
                      '</div>' +
                    '</div>'
                     + messages.innerHTML
    }
    // 取得メッセージが相手のものであれば左側に表示
    else{
      messages.innerHTML =
                    '<div class="msg">' +
                      '<figure class="msg-img-left">' +
                       '<img src="/user_images/' + msginfo[1] + '">' +
                       '<figcaption class="msg-img-description">' + msginfo[2] +
                       '</figcaption>' +
                      '</figure>' +
                      '<div class="msg-text-right">' +
                       '<p class="msg-text">' + msginfo[0].replace(/\n/g, '<br>') + '</p>' +
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
  const content = document.getElementById('chat-input')         // メッセージ
  const talk_id = document.getElementById('h_talk_id')          // TalkID
  const user_id = document.getElementById('h_user_id')          // ユーザID（ログイン者）
  const user_image = document.getElementById('h_user_image')    // プロファイルファイル名
  const user_name  = document.getElementById('h_user_name')     // ユーザ名（ログイン者）
  const button = document.getElementById('msg_submit')          // 送信ボタン
  // イベント登録
  button.addEventListener('click', function(){
    // 入力チェック
    if (content.value == ''){
      alert('メッセージを入力してください。');
      return false;
    }
    else{
      if (content.value.indexOf(':::') > 0){
          alert(':::と続けて入力することはできません。');
          return false;
      }
    }
    // サーバへ送信（非同期）
    App.room.speak(content.value, talk_id.value, user_id.value, user_image.value, user_name.value)
    // 入力メッセージ初期化
    content.value = ""
  })
})
