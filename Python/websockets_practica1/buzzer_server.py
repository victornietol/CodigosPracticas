import asyncio
import websockets
from websockets.exceptions import ConnectionClosed

'''
    Servidor para detectar que mensaje llega primero entre dos clientes y dependiendo de ello
    dar una respuesta.
'''

# clientes
clients = []
fastest_time = None

# funcion para manejar los mensajes de los clientes
async def handle_message(websocket):
    global clients
    global fastest_time
    message = await websocket.recv()
    try:
        if message == "buzz":
            response_time = asyncio.get_event_loop().time()
            clients.append([websocket, response_time])
            if len(clients) == 1:
                # Responder que es el primer lugar
                await websocket.send("Primer lugar")
                fastest_time = response_time
            else:
                # Responder cuanto tiempo extra se tardo a comparacion del primer lugar
                t = round(response_time - fastest_time, 2)
                await websocket.send(f"Tiempo de respuesta: {t} seg mas lento")
    except ConnectionClosed:
        print("Cliente desconectado.")

# Iniciar servidor
async def start_server():
    async with websockets.serve(handle_message, "localhost", 8765):
        print("Servidor iniciado")
        await asyncio.Future()

asyncio.run(start_server())