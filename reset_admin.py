from app import create_app, db
from app.models import Usuario

app = create_app()

with app.app_context():
    print("--- INICIANDO REPARACIÓN DE ADMIN ---")
    
    # 1. Buscamos si ya existe el usuario 'admin'
    admin = Usuario.query.filter_by(username='admin').first()
    
    if admin:
        print("1. El usuario 'admin' ya existía.")
        print("2. Actualizando su contraseña y permisos...")
        # Forzamos la nueva contraseña y el permiso de admin
        admin.set_password('admin123')
        admin.es_admin = True
    else:
        print("1. El usuario 'admin' NO existía.")
        print("2. Creándolo desde cero...")
        # Lo creamos nuevo
        admin = Usuario(username='admin', es_admin=True)
        admin.set_password('admin123')
        db.session.add(admin)
    
    # 3. Guardamos los cambios en la base de datos
    db.session.commit()
    print("---------------------------------------")
    print("¡ÉXITO! Credenciales actualizadas:")
    print("Usuario:    admin")
    print("Contraseña: admin123")
    print("---------------------------------------")