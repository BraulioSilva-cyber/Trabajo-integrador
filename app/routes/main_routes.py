from flask import Blueprint, render_template, request, flash, redirect, url_for
from app.models import Ciudad, Historial
# --- CAMBIO 1: Agregamos login_required aquí ---
from flask_login import current_user, login_required
from app import db
import heapq 

main_bp = Blueprint('main', __name__)

# --- CONFIGURACIÓN ---
VELOCIDAD_PROMEDIO = 70 # km/h

# --- FUNCIÓN AUXILIAR: CALCULAR DISTANCIA ---
def calcular_distancia(c1, c2):
    # Fórmula Eucladiana aproximada (111.1 km por grado)
    return ((c1.latitud - c2.latitud)**2 + (c1.longitud - c2.longitud)**2)**0.5 * 111.1

# --- GENERADOR DE GRAFO AUTOMÁTICO (RED MEJORADA) ---
def construir_grafo_automatico():
    """
    Lógica ajustada:
    1. Conecta con los 10 vecinos más cercanos (Antes 8).
    2. Conecta con TODO lo que esté a menos de 180km (Antes 150km).
    Esto ayuda a evitar desvíos innecesarios como el de La Maná.
    """
    ciudades = Ciudad.query.all()
    grafo = {}
    rutas_visuales = []
    
    # Inicializar grafo
    for c in ciudades:
        grafo[c.id] = []
    
    conexiones_hechas = set()

    for c_origen in ciudades:
        candidatos = []
        
        # 1. CALCULAR DISTANCIA A TODOS
        for c_destino in ciudades:
            if c_origen.id == c_destino.id: continue
            
            dist = calcular_distancia(c_origen, c_destino)
            candidatos.append((dist, c_destino))
        
        # 2. ORDENAR POR CERCANÍA
        candidatos.sort(key=lambda x: x[0])
        
        # 3. SELECCIONAR CONEXIONES (AJUSTE AQUÍ)
        # Subimos a 10 vecinos para tener más opciones de ruta
        vecinos_seleccionados = candidatos[:10]
        
        # Subimos a 180km para encontrar "autopistas" directas
        for cand in candidatos[10:]: 
            distancia = cand[0]
            ciudad_vecina = cand[1]
            if distancia <= 180: 
                vecinos_seleccionados.append((distancia, ciudad_vecina))

        # 4. GUARDAR EN EL GRAFO
        for dist, c_vecino in vecinos_seleccionados:
            grafo[c_origen.id].append((c_vecino.id, dist))
            
            ids_par = tuple(sorted((c_origen.id, c_vecino.id)))
            if ids_par not in conexiones_hechas:
                conexiones_hechas.add(ids_par)
                rutas_visuales.append({
                    'lat1': c_origen.latitud, 'lng1': c_origen.longitud,
                    'lat2': c_vecino.latitud, 'lng2': c_vecino.longitud,
                    'distancia': round(dist, 2),
                    'nombre': f"{c_origen.nombre} ↔ {c_vecino.nombre}"
                })
                
    return grafo, rutas_visuales

# --- LÓGICA DIJKSTRA ---
def calcular_dijkstra(inicio_id, fin_id):
    grafo, _ = construir_grafo_automatico()

    if inicio_id not in grafo or fin_id not in grafo:
        return None, float('inf')

    cola_prioridad = [(0, inicio_id)]
    distancias = {node: float('inf') for node in grafo}
    distancias[inicio_id] = 0
    padres = {node: None for node in grafo}
    
    while cola_prioridad:
        distancia_actual, nodo_actual = heapq.heappop(cola_prioridad)
        
        if nodo_actual == fin_id: break 
        if distancia_actual > distancias.get(nodo_actual, float('inf')): continue
            
        for vecino_id, peso in grafo.get(nodo_actual, []):
            distancia = distancia_actual + peso
            if distancia < distancias.get(vecino_id, float('inf')):
                distancias[vecino_id] = distancia
                padres[vecino_id] = nodo_actual
                heapq.heappush(cola_prioridad, (distancia, vecino_id))
                
    camino = []
    paso_actual = fin_id
    
    if distancias.get(fin_id, float('inf')) == float('inf'):
        return None, float('inf')
        
    while paso_actual is not None:
        ciudad = Ciudad.query.get(paso_actual)
        camino.insert(0, {
            'nombre': ciudad.nombre,
            'lat': ciudad.latitud, 
            'lng': ciudad.longitud 
        })
        paso_actual = padres.get(paso_actual)
        
    return camino, distancias[fin_id]

# --- RUTAS WEB ---

@main_bp.route('/', methods=['GET', 'POST'])
@login_required # --- CAMBIO 2: ¡El candado! Ahora redirige al login ---
def home():
    resultado = None
    distancia_grafo = 0
    tiempo_estimado = 0
    
    ciudades = Ciudad.query.order_by(Ciudad.nombre).all()
    _, rutas_automaticas = construir_grafo_automatico()

    if request.method == 'POST':
        if 'calcular' in request.form:
            try:
                origen_id = int(request.form.get('origen'))
                destino_id = int(request.form.get('destino'))
                
                if origen_id == destino_id:
                    flash("El origen y destino son iguales.", "warning")
                else:
                    camino, dist = calcular_dijkstra(origen_id, destino_id)
                    
                    if camino:
                        resultado = {'coords': camino}
                        distancia_grafo = round(dist, 2)
                        
                        tiempo_horas = distancia_grafo / VELOCIDAD_PROMEDIO
                        horas = int(tiempo_horas)
                        minutos = int((tiempo_horas - horas) * 60)
                        tiempo_estimado = f"{horas}h {minutos}m"
                        
                        flash(f"Ruta calculada exitosamente.", "success")
                        
                        # GUARDAR HISTORIAL SI ESTÁ LOGUEADO
                        if current_user.is_authenticated:
                            c1 = Ciudad.query.get(origen_id)
                            c2 = Ciudad.query.get(destino_id)
                            try:
                                log = Historial(
                                    usuario_id=current_user.id, 
                                    accion="DIJKSTRA", 
                                    detalle=f"Ruta: {c1.nombre} -> {c2.nombre}"
                                )
                                db.session.add(log)
                                db.session.commit()
                            except Exception as e:
                                db.session.rollback()
                                print(f"Error guardando historial: {e}")

                    else:
                        flash("No se encontró camino posible entre estas ciudades.", "danger")
            except ValueError:
                flash("Error: Selecciona ciudades válidas.", "danger")

    return render_template('index.html', 
                           ciudades=ciudades, 
                           resultado=resultado, 
                           distancia=distancia_grafo, 
                           tiempo=tiempo_estimado,
                           rutas_existentes=rutas_automaticas)

@main_bp.route('/crear_ciudad', methods=['POST'])
@login_required # También protegemos esta ruta por seguridad
def crear_ciudad():
    try:
        nombre = request.form.get('nombre')
        lat = float(request.form.get('lat')) 
        lng = float(request.form.get('lng'))
        
        nueva_ciudad = Ciudad(nombre=nombre, latitud=lat, longitud=lng)
        db.session.add(nueva_ciudad)
        db.session.commit()
        
        if current_user.is_authenticated:
            try:
                h = Historial(usuario_id=current_user.id, accion="CREAR CIUDAD", detalle=nombre)
                db.session.add(h)
                db.session.commit()
            except Exception:
                db.session.rollback()
            
        flash('Ciudad guardada. La red se ha recalculado automáticamente.', 'success')
    except Exception as e:
        flash(f'Error: {str(e)}', 'danger')
        
    return redirect(url_for('main.home'))