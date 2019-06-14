App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    const messages = document.querySelector(".messages");
    const tmp = document.createElement("div");
    tmp.innerHTML = data['message'];
    messages.appendChild(tmp.firstElementChild);
  },

  speak: function(message) {
    return this.perform("speak", { message });
  }
});

document.addEventListener("DOMContentLoaded", () => {
  const roomForm = document.getElementById("room_form");
  roomForm.addEventListener("keypress", event => {
    if (event.keyCode === 13) {
      event.preventDefault();
      App.room.speak(event.target.value);
      event.target.value = "";
    }
  });
})
