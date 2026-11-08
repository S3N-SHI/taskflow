# TaskFlow

Aplicación móvil para la gestión organizada de tareas diarias, desarrollada en Flutter con arquitectura MVVM y navegación declarativa.

## 1. Problema y Alcance
Muchos estudiantes y profesionales enfrentan desorganización en sus pendientes cotidianos por la falta de herramientas ligeras que clasifiquen prioridades y faciliten el seguimiento de objetivos diarios sin sobrecarga visual. TaskFlow aborda esta necesidad con una interfaz reactiva, navegación intuitiva y una arquitectura escalable.

## 2. Usuario Objetivo
Estudiantes universitarios y desarrolladores que necesitan registrar, clasificar por prioridad y completar sus tareas y compromisos académicos de forma ágil desde sus teléfonos móviles.

## 3. Historias de Usuario
1. **HU01 - Visualizar tareas:** Como usuario, quiero ver la lista completa de mis tareas para conocer mis pendientes organizados.
2. **HU02 - Consultar detalle:** Como usuario, quiero tocar una tarea para ver su descripción detallada, prioridad y estado actual.
3. **HU03 - Crear tarea:** Como usuario, quiero registrar una nueva tarea con título y prioridad para incorporarla a mi backlog.
4. **HU04 - Marcar como completada:** Como usuario, quiero actualizar el estado de una tarea para llevar el control de avance diario.
5. **HU05 - Eliminar tarea:** Como usuario, quiero descartar tareas obsoletas para mantener limpia mi lista.

## 4. Modelo de Datos Principal (`Task`)
* `id` (int): Identificador único.
* `title` (String): Título descriptivo de la tarea.
* `description` (String): Detalle extendido de la tarea.
* `priority` (String): Nivel de prioridad (`Alta`, `Media`, `Baja`).
* `isCompleted` (bool): Estado booleano de finalización.

## 5. Boceto de Pantallas
1. **Pantalla de Listado (`TaskListView`):** Barra superior con título "Mis tareas" y `ListView.builder` de tarjetas interactivas (`TaskCard`).
2. **Pantalla de Detalle (`TaskDetailView`):** Muestra título, descripción completa, chip de prioridad, icono de estado y botón tonal de regreso.
3. **Formulario de Registro (Planificada):** Campos para ingresar título, descripción y selector de prioridad.

## 6. Endpoints REST Requeridos
| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `GET` | `/api/tasks` | Listar todas las tareas del usuario |
| `GET` | `/api/tasks/:id` | Obtener el detalle específico de una tarea |
| `POST` | `/api/tasks` | Crear una nueva tarea |
| `PUT` | `/api/tasks/:id` | Actualizar título, descripción o estado |
| `DELETE` | `/api/tasks/:id` | Eliminar una tarea del sistema |
