from flask import Flask, jsonify, request, render_template, session, redirect, url_for
from flask_wtf import CSRFProtect
import operations as op
from functools import wraps

app = Flask(__name__)
app.secret_key = "clave_prueba_secreta"
csrf = CSRFProtect(app)

def login_logic(username, password):
    code_response = op.login(username, password)
    if code_response == 200:
        return {"message": "Inicio de sesión exitoso."}, code_response
    elif code_response == 401:
        return {"message": "Username o password incorrectos."}, code_response
    
def register_logic(username, password):
    print(password)
    code_response = op.create_user(username, password)
    if code_response == 201:
        message = "Usuario creado con exito."
    elif code_response == 409:
        message = "El username ya existe."
    elif code_response == 400:
        message = "Ocurrio un error en operations.py"
    return {"message": message}, code_response
    
# Decoradores para verificar inicio de session
def login_required(function):
    @wraps(function)
    def decorated_function(*args, **kwargs):
        if "username" not in session: # No hay sesion iniciada
            return redirect(url_for("login_template"))
        return function(*args, **kwargs)
    return decorated_function

def already_login(function):
    @wraps(function)
    def decorated_function(*args, **kwargs):
        if "username" in session:
            return redirect(url_for("index"))
        return function(*args, **kwargs)
    return decorated_function





# Front
@app.route("/")
@login_required
def index():
    return render_template("index.html", username=session["username"])


@app.route("/login", methods=["GET", "POST"])
@already_login # Verificar que no este ya logueado
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


@app.route("/register", methods=["GET", "POST"])
@already_login
def register_template():
    if request.method == "GET":
        render = render_template("register.html")

    elif request.method == "POST":
        username = request.form.get("username")
        password1 = request.form.get("password1")
        password2 = request.form.get("password2")
        if password1!=password2:
            render = render_template("register.html", message_error="Las contraseñas no coinciden.")
        else:
            response, code_status = register_logic(username, password1)
            if code_status == 201:
                render = render_template("register.html", modal="1", message=response.get("message"))
            else:
                render = render_template("register.html", message_error=response.get("message"))

    return render

@app.route("/logout", )
@login_required
def logout_template():
    session.clear()
    return redirect(url_for("login_template"))






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