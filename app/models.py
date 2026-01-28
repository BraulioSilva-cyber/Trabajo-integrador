from app import db
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

class Usuario(UserMixin, db.Model):
    __tablename__ = 'usuarios'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)
    es_admin = db.Column(db.Boolean, default=False) # <--- NUEVO CAMPO

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

class Historial(db.Model): # <--- NUEVA TABLA
    __tablename__ = 'historial'
    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'))
    accion = db.Column(db.String(100))
    detalle = db.Column(db.Text)
    fecha = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relación para saber el nombre del usuario
    usuario = db.relationship('Usuario', backref='actividades')

# --- (Las clases Ciudad y Ruta se quedan igual que antes) ---
class Ciudad(db.Model):
    __tablename__ = 'ciudades'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False, unique=True)
    latitud = db.Column(db.Float, nullable=False)
    longitud = db.Column(db.Float, nullable=False)
    
    rutas_salida = db.relationship('Ruta', foreign_keys='Ruta.origen_id', backref='origen', lazy=True)
    rutas_entrada = db.relationship('Ruta', foreign_keys='Ruta.destino_id', backref='destino', lazy=True)

class Ruta(db.Model):
    __tablename__ = 'rutas'
    id = db.Column(db.Integer, primary_key=True)
    origen_id = db.Column(db.Integer, db.ForeignKey('ciudades.id'), nullable=False)
    destino_id = db.Column(db.Integer, db.ForeignKey('ciudades.id'), nullable=False)
    distancia = db.Column(db.Float, nullable=False)