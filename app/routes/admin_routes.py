from flask import Blueprint, render_template, request
from flask_login import login_required
from app.models import Historial, Usuario  # <--- CORRECCIÓN: Usamos Usuario
from app import db
from datetime import datetime, timedelta

admin_bp = Blueprint('admin', __name__, url_prefix='/admin')

@admin_bp.route('/dashboard')
@login_required
def dashboard():
    # 1. Unimos la tabla Historial con USUARIO (español)
    query = Historial.query.join(Usuario)

    # 2. Filtros (Opcional)
    usuario_filtro = request.args.get('usuario')
    fecha_filtro = request.args.get('fecha')

    if usuario_filtro:
        query = query.filter(Usuario.username.ilike(f"%{usuario_filtro}%"))
    
    if fecha_filtro:
        try:
            fecha_dt = datetime.strptime(fecha_filtro, '%Y-%m-%d')
            start = fecha_dt
            end = fecha_dt + timedelta(days=1)
            query = query.filter(Historial.fecha >= start, Historial.fecha < end)
        except ValueError:
            pass 

    # 3. CONSULTA FINAL: Ordenamos por fecha y LIMITAMOS A 50
    logs = query.order_by(Historial.fecha.desc()).limit(50).all()

    return render_template('admin_dashboard.html', logs=logs)