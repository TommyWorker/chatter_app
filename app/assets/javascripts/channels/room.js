App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  speakheroku: function() {
    return this.perform('speakheroku');
  },

  logs: function() {
    return this.perform('logs');
  }
});
