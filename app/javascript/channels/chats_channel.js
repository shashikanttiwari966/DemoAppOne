import consumer from "./consumer"

consumer.subscriptions.create({channel: "ChatsChannel", chat_id: "message"}, {
  connected() {
    console.log("Connected to the chat room!");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Connected to the chat room!");
    // Called when there's incoming data on the websocket for this channel
  }
});
