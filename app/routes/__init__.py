print(">>> CARGANDO __INIT__.PY CORREGIDO <<<") # <--- Mensaje de prueba

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager # Importación vital
from config import Config

db = SQLAlchemy()
login_manager = LoginManager()       # Creación del objeto

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # 1. Inicializar Base de Datos
    db.init_app(app)
    
    # 2. Inicializar Login (LA PARTE QUE FALLABA)
    login_manager.init_app(app)
    
    # 3. Configurar redirección si no hay login
    login_manager.login_view = 'auth.login'
    login_manager.login_message = "Por favor inicia sesión para ver el mapa."

    # 4. Cargador de usuarios
    from app.models import Usuario
    @login_manager.user_loader
    def load_user(user_id):
        return Usuario.query.get(int(user_id))

    # 5. Registrar Rutas
    from app.routes.main_routes import main_bp
    app.register_blueprint(main_bp)
    
    from app.routes.auth_routes import auth_bp
    app.register_blueprint(auth_bp)

    # 6. Crear tablas
    with app.app_context():
        db.create_all()

    return app