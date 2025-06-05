from fastapi import FastAPI, WebSocket, WebSocketDisconnect
import uvicorn

app = FastAPI()

@app.websocket("/ws")
async def websocket_enpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()

            print(f"Server Received: {data}")

            response = f"Message save: {data}"
            await websocket.send_text(response)

            print(f"Server Sent: {response}")
    except WebSocketDisconnect:
        print("Cliente desconectado")

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)