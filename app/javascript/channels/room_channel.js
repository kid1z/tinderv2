import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  let content = document.querySelector(".content");
  let contentArray = content.children //check inside Content class has any div tag?
  for (let i = 0; i < contentArray.length; i++) {
    // if inside Content class contains heading class, implement everything below
    // it can minimizes error occur
    if(contentArray[i].classList.contains("heading")) {
      const room_id = document.querySelector('input[name="room"]').value;
      const user_id = parseInt(document.querySelector('input[name="user_id"]').value)

      consumer.subscriptions.create({ channel: "RoomChannel", room: room_id}, {

        connected() {
          // Called when the subscription is ready for use on the server
          console.log("already")
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },
        
        received(data) {
          // Called when there's incoming data on the websocket for this channel
          let textContent = document.querySelector(".text-content")
          let input = document.querySelector('#text')
          this.appendLine(data, textContent)
          this.scrollToBottom(textContent)
          input.value = ""
        },

        appendLine(data, e) {
          let html = this.createLine(data)
          console.log("html: ", html)
          console.log("data: ", data)
          e.insertAdjacentHTML("beforeend",html)
        },

        createLine(data) {
          return data.receiver === user_id ? `<p class="sender">${data.text}</p>` : `<p>${data.text}</p>`
        },
        
        scrollToBottom(e) {
          e.scrollTo({ top: e.scrollHeight, behavior: "smooth" });
        }
      });
    }
  }
})