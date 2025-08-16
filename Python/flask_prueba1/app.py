from flask import Flask, jsonify, request
import operations as op

app = Flask(__name__)

@app.route("/", methods=['GET'])
def index():
    return jsonify({"status":"ok"}), 200


@app.get("/api/v1/user/list")
def list_users():
    '''
    Listar usuarios
    '''
    users = op.get_users()
    return jsonify(users), 200


@app.post("/api/v1/user/login")
def login():
    '''
    Iniciar sesion
    '''
    # Leer como json
    data = request.get_json(silent=True)
    if data is None: # Intentar leer si viene como form
        data = request.form.to_dict()
    
    if not data:
        return jsonify({"error": "No se enviaron datos."}), 400
    
    username = data.get("username")
    password = data.get("password")

    code_response = op.login(username, password)
    if code_response==200:
        message = "Inicio de sesión exitoso."
    elif code_response==401:
        message = "Username o password incorrectos."
    return jsonify({"message": message}), code_response


@app.post("/api/v1/user/register")
def register():
    '''
    Registrar usuarios
    '''
    # Leer como json
    data = request.get_json(silent=True)
    if data is None: # Intentar leer si viene como form
        data = request.form.to_dict()
    
    if not data:
        return jsonify({"error": "No se enviaron datos."}), 400
    
    username = data.get("username")
    password = data.get("password")

    code_response = op.create_user(username, password)
    
    if code_response == 201:
        message = "Usuario creado con exito."
    elif code_response == 409:
        message = "El username ya existe."
    elif code_response == 400:
        message = "Ocurrio un error en operations.py"

    return jsonify({"message": message}), code_response


if __name__ == "__main__":
    app.run(debug=True)