import asyncio
import websockets

async def hello(websocket):
    message = await websocket.recv()
    print(f"<- Server Received: {message}")

    response = f"Mensaje recibido {message}"
    await websocket.send(response)
    print(f"-> Server Sent: {response}")

async def main():
    async with websockets.serve(hello, "localhost", 8765):
        print("Server Iniciado...")
        await asyncio.Future() # ejecutando siempre

if __name__ == "__main__":
    asyncio.run(main())