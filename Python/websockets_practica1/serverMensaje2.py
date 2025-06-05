import asyncio
import websockets
from datetime import datetime

cont = 0

async def echo(websocket):
    global cont
    async for message in websocket:
        cont += 1
        print(f"<- Server Received: {message}")

        with open("mensajes.txt", "a", encoding="utf-8") as file:
            file.write(f"{cont}. mensaje='{message}', fecha-hora='{datetime.now()}'\n") # Guardar mensaje

        response = f"Message save: {message}"
        await websocket.send(response) # Enviando respuesta al cliente
        print(f"-> Server Sent: {response}")


async def main():
    print("Servidor iniciado...")
    async with websockets.serve(echo, "localhost", 8765) as server:
        await server.serve_forever()

if __name__ == "__main__":
    asyncio.run(main())