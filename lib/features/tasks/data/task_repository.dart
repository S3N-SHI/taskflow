import '../domain/task.dart';
import 'task_api_service.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> getTaskById(int id);
  int? get lastStatusCode;
}

class RemoteTaskRepository implements TaskRepository {
  RemoteTaskRepository({TaskApiService? apiService})
      : _apiService = apiService ?? TaskApiService();

  final TaskApiService _apiService;
  List<Task> _cachedTasks = [];

  @override
  int? get lastStatusCode => _apiService.lastStatusCode;

  @override
  Future<List<Task>> getTasks() async {
    _cachedTasks = await _apiService.fetchTasks();
    return _cachedTasks;
  }

  @override
  Future<Task> getTaskById(int id) async {
    return _cachedTasks.firstWhere(
      (task) => task.id == id,
      orElse: () => throw Exception('Tarea con ID $id no encontrada'),
    );
  }
}
