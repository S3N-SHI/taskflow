import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Configurar entorno Flutter',
      description:
          'Validar SDK, dependencias y conexión ADB con el dispositivo',
      priority: 'Alta',
      isCompleted: true,
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Definir modelo de datos Task',
      description: 'Incluir identificador, prioridad, estado y userId',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Implementar rutas con GoRouter',
      description: 'Configurar navegación declarativa entre listado y detalle',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Separar capas con MVVM',
      description:
          'Desacoplar vistas, ViewModel y repositorio mediante Provider',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Documentar alcance en README',
      description:
          'Redactar historias de usuario, criterios y endpoints previstos',
      priority: 'Baja',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  List<Task> getTasks() => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}
