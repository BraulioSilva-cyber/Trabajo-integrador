from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_user, logout_user, login_required, current_user
from app import db
# 👇 AQUÍ ES DONDE VA LA IMPORTACIÓN DE HISTORIAL (Línea 5)
from app.models import Usuario, Historial 

auth_bp = Blueprint('auth', __name__)

# --- LOGIN (INICIAR SESIÓN) ---
@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    # Si ya está logueado, lo mandamos a su sitio correspondiente
    if current_user.is_authenticated:
        if current_user.es_admin:
            return redirect(url_for('admin.dashboard'))
        return redirect(url_for('main.home'))
    
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        user = Usuario.query.filter_by(username=username).first()
        
        # Verificamos usuario y contraseña
        if user and user.check_password(password):
            login_user(user)
            
            # ---> 1. GUARDAR EN EL HISTORIAL (AUDITORÍA) <---
            # Creamos el registro de que alguien entró
            log = Historial(usuario_id=user.id, accion="Login", detalle="Ingreso al sistema")
            db.session.add(log)
            db.session.commit()
            
            flash(f'¡Bienvenido, {user.username}!', 'success')
            
            # ---> 2. REDIRECCIÓN INTELIGENTE <---
            # Si es Admin (es_admin=1), va al Panel de Control.
            # Si es Usuario Normal (es_admin=0), va al Mapa.
            if user.es_admin:
                return redirect(url_for('admin.dashboard'))
            else:
                return redirect(url_for('main.home'))
        else:
            flash('Usuario o contraseña incorrectos', 'danger')
            
    return render_template('login.html')

# --- REGISTRO (CREAR CUENTA) ---
@auth_bp.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
        
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        
        # Verificar si ya existe
        if Usuario.query.filter_by(username=username).first():
            flash('Ese nombre de usuario ya existe', 'warning')
            return redirect(url_for('auth.register'))
            
        # Crear nuevo usuario (por defecto NO es admin)
        nuevo_usuario = Usuario(username=username, es_admin=False)
        nuevo_usuario.set_password(password)
        
        db.session.add(nuevo_usuario)
        db.session.commit()
        
        flash('Cuenta creada. Ahora puedes iniciar sesión.', 'success')
        return redirect(url_for('auth.login'))
        
    return render_template('register.html')

# --- LOGOUT (CERRAR SESIÓN) ---
@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Has cerrado sesión correctamente.', 'info')
    return redirect(url_for('auth.login'))