from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from config import Config

# Inicialización de extensiones
db = SQLAlchemy()
login_manager = LoginManager()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # 1. Iniciar Base de Datos y Login
    db.init_app(app)
    login_manager.init_app(app)

    # Configuración del Login
    login_manager.login_view = 'auth.login'
    login_manager.login_message = 'Por favor inicia sesión para acceder.'

    # --- CORRECCIÓN CLAVE: Usamos 'Usuario' (como en tu models.py) ---
    from app.models import Usuario
    @login_manager.user_loader
    def load_user(user_id):
        return Usuario.query.get(int(user_id))
    # -----------------------------------------------------------------

    # 2. REGISTRO DE RUTAS
    
    # Rutas de Autenticación
    from app.routes.auth_routes import auth_bp
    app.register_blueprint(auth_bp)

    # Rutas del Mapa (Main)
    from app.routes.main_routes import main_bp
    app.register_blueprint(main_bp)

    # Rutas de Admin (Para que funcione el Dashboard)
    from app.routes.admin_routes import admin_bp
    app.register_blueprint(admin_bp)

    # Crear tablas si faltan
    with app.app_context():
        db.create_all()

    return app