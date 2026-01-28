// Esperamos a que jQuery y la página estén listos
$(document).ready(function() {
    
    // 1. ACTIVAR SELECT2 (BUSCADOR INTELIGENTE)
    // Busca todos los elementos <select> con la clase 'form-select' y transfórmalos
    $('.form-select').select2({
        width: '100%',              // Que ocupe todo el ancho
        placeholder: "Escribe para buscar...", 
        allowClear: true,           // Permite borrar la selección con una X
        language: {
            noResults: function() {
                return "No se encontraron resultados";
            }
        }
    });

});

// Funciones estándar de JavaScript (Alertas y Botones)
document.addEventListener('DOMContentLoaded', function() {
    
    // 2. CERRAR ALERTAS AUTOMÁTICAMENTE (4 segundos)
    setTimeout(function() {
        let alertas = document.querySelectorAll('.alert');
        alertas.forEach(function(alerta) {
            let alertInstance = new bootstrap.Alert(alerta);
            alertInstance.close();
        });
    }, 4000); 

    // 3. EFECTO "CARGANDO" EN LOS BOTONES
    let forms = document.querySelectorAll('form');
    forms.forEach(function(form) {
        form.addEventListener('submit', function() {
            let btn = form.querySelector('button[type="submit"]');
            
            // Verificamos si es el botón de filtrar (para no bloquearlo) o uno de guardar
            if(btn && !btn.innerText.includes("Filtrar")) {
                btn.style.width = btn.offsetWidth + 'px';
                btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> ...';
                btn.classList.add('disabled');
            }
        });
    });

});