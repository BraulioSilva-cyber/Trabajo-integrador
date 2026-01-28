import os

class Config:
    # XAMPP por defecto: usuario 'root', contraseña vacía
    SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://root:@localhost/proyecto_grafo_db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = 'tu_clave_secreta'