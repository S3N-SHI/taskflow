import '../domain/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> getTaskById(int id);
}

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = const [
    Task(
      id: 1,
      title: 'Leer documentación',
      description: 'Revisar ListView.builder, GoRouter y Provider',
      priority: 'Alta',
      isCompleted: false,
    ),
    Task(
      id: 2,
      title: 'Diseñar la pantalla',
      description: 'Definir la tarjeta TaskCard reutilizable',
      priority: 'Media',
      isCompleted: false,
    ),
    Task(
      id: 3,
      title: 'Preparar evidencia',
      description: 'Tomar capturas del flujo y el avance',
      priority: 'Baja',
      isCompleted: true,
    ),
    Task(
      id: 4,
      title: 'Organizar el backlog',
      description: 'Priorizar y estructurar tareas pendientes',
      priority: 'Alta',
      isCompleted: false,
    ),
    Task(
      id: 5,
      title: 'Revisar código',
      description: 'Ejecutar dart format y flutter analyze',
      priority: 'Media',
      isCompleted: false,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  @override
  Future<Task> getTaskById(int id) async {
    return _tasks.firstWhere(
      (task) => task.id == id,
      orElse: () => throw Exception('Tarea no encontrada'),
    );
  }
}
