import asyncio
import websockets

async def hello():
    url = "ws://localhost:8765"
    url_fastAPI = "ws://localhost:8000/ws"
    async with websockets.connect(url) as websocket:
        name = input("Ingresa un nombre: ")

        await websocket.send(name)
        print(f"Client Sent: {name}")

        greeting = await websocket.recv()
        print(f"Client Received: {greeting}")

if __name__ == "__main__":
    asyncio.run(hello())