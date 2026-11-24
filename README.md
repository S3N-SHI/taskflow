# TaskFlow

Aplicación móvil desarrollada en Flutter para gestionar pendientes académicos con arquitectura MVVM y navegación declarativa.

## Alcance de TaskFlow

Problema: necesito organizar actividades académicas y saber cuáles faltan.
Usuario objetivo: estudiante que planifica entregas semanales.

### Historias de usuario y criterios de aceptación
1. Como estudiante, quiero listar mis tareas para ver qué debo hacer.
   Criterio: la lista muestra título, prioridad y estado de cada tarea.
2. Como estudiante, quiero abrir una tarea para leer su descripción.
   Criterio: al tocar una tarjeta aparece el detalle de la tarea elegida.
3. Como estudiante, quiero crear una tarea para registrar un pendiente.
   Criterio: el formulario guarda una tarea válida y la lista la muestra.
4. Como estudiante, quiero editar una tarea para corregir sus datos.
   Criterio: los cambios guardados aparecen en lista y detalle.
5. Como estudiante, quiero eliminar una tarea terminada para limpiar la lista.
   Criterio: después de confirmar, la tarea desaparece de la lista.

### Modelo de datos
Task: id (entero único), title (texto), description (texto),
priority (Alta, Media o Baja), isCompleted (verdadero/falso),
userId (entero que identifica al usuario de prueba).

### Pantallas previstas
Lista: tarjetas de tareas y acción para crear.
Detalle: información completa y futuras acciones de editar o eliminar.
Formulario: campos de título, descripción y prioridad.

### Requisitos no funcionales
La navegación debe tener textos comprensibles.
Un id inexistente debe mostrar un mensaje en vez de cerrar la app.

### Contrato de API que necesitaremos
GET /tasks        listar tareas
GET /tasks/:id    consultar detalle
POST /tasks       crear tarea
PATCH /tasks/:id  actualizar tarea
DELETE /tasks/:id eliminar tarea

## API de tareas
* **URL exacta:** `https://jsonplaceholder.typicode.com/todos?userId=2`
* **Parámetro de filtro (`userId`):** Se eligió `userId = 2` para filtrar únicamente las tareas correspondientes al segundo usuario de prueba.
* **Campos recibidos desde el servidor:** `id` (entero), `userId` (entero), `title` (texto) y `completed` (booleano mapeado a `isCompleted`).
* **Valores completados por defecto en TaskFlow:** Como el endpoint no envía descripción ni prioridad, `Task.fromJson` asigna `'Sin descripción (API)'` a `description` y `'Sin prioridad (API)'` a `priority`.
* **Persistencia actual:** Marcar o desmarcar una tarea como completada (`toggleCompleted`) actualiza únicamente la copia en memoria del repositorio; al reiniciar la aplicación, los estados vuelven a cargarse desde el servidor.

## Estados asíncronos (Sesión 8)
* **Carga:** Se observa mediante CircularProgressIndicator mientras finaliza la petición GET a la API.
* **Éxito:** Se renderiza la lista de tareas remotas del usuario 2 con soporte de RefreshIndicator (deslizar hacia abajo) y botón de actualización en la barra superior.
* **Vacío:** Se comprobó cambiando temporalmente userId = 9999 en TaskApiService, mostrando el mensaje 'Todavía no hay tareas para mostrar.' y el botón 'Actualizar'.
* **Error y reintento:** Se provocó desconectando el Wi-Fi/datos del dispositivo móvil y pulsando actualizar; se muestra 'No se pudieron cargar las tareas.' junto al botón 'Reintentar' que recupera la lista al reconectar.

## Estados asíncronos (Sesión 8)
* **Carga:** Se muestra un indicador circular mientras Dio resuelve la petición GET.
* **Éxito:** Se renderiza la lista con soporte para refresco manual (botón superior y gesto Pull-to-refresh).
* **Error y Reintento:** Provocado desactivando los datos móviles y Wi-Fi en el dispositivo y pulsando actualizar; muestra el aviso de fallo y el botón Reintentar recupera la lista al reconectar internet sin reiniciar la app.
* **Vacío:** Provocado cambiando temporalmente userId = 9999 en TaskApiService, donde la API responde 200 OK con lista vacía [] y la app muestra el mensaje correspondiente con el botón Actualizar.
