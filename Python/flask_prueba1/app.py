from flask import Flask, jsonify, request, render_template, session, redirect, url_for
import operations as op
from functools import wraps

app = Flask(__name__)
app.secret_key = "clave_prueba_secreta"

def login_logic(username, password):
    code_response = op.login(username, password)
    if code_response == 200:
        return {"message": "Inicio de sesión exitoso."}, code_response
    elif code_response == 401:
        return {"message": "Username o password incorrectos."}, code_response
    
# Decoradores para verificar inicio de session
def login_required(function):
    @wraps(function)
    def decorated_function(*args, **kwargs):
        if "username" not in session: # No hay sesion iniciada
            return redirect(url_for("login_template"))
        return function(*args, **kwargs)
    return decorated_function




# Front
@app.route("/")
@login_required
def index():
    return render_template("index.html", username=session["username"])


@app.route("/login", methods=["GET", "POST"])
def login_template():
    if request.method == "GET":
        render = render_template("login.html")

    elif request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        response, code_status = login_logic(username, password)
        if code_status == 200:
            session["username"] = username # Guardar inicio de sesion
            render = redirect(url_for("index"))
        elif code_status == 401:
            render = render_template("login.html", message=response.get("message"))

    return render


@app.route("/register")
def register_template():
    return render_template("register.html")






# API
@app.get("/api/v1/user/list")
def list_users():
    '''
    Listar usuarios
    '''
    users = op.list_usernames()
    return jsonify(users), 200


@app.get("/api/v1/users")
def get_users():
    '''Obtener usuarios'''
    users = op.get_users()
    if users is not None:
        return jsonify(users), 200
    return jsonify({"message": "Error en la consulta"}, 400)


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

    response, code_status = login_logic(username, password)
    return jsonify(response), code_status


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