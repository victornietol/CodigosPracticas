url = "ws://localhost:8765"
urlFastAPI = "ws://localhost:8000/ws"
const socket = new WebSocket(url);

socket.onopen = () => {
    console.log("Conectado al servidor websocket");
    // socket.send("Me he conectado");
}

socket.onmessage = (event) => {
    document.getElementById("response").innerHTML += `<p>${event.data}</p>`;
    console.log(event.data);
}

function send() {
    message = document.getElementById("message").value;
    socket.send(message);
}