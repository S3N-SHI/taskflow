import 'package:flutter/foundation.dart';
import '../data/task_repository.dart';
import '../domain/task.dart';

class TaskListViewModel extends ChangeNotifier {
  TaskListViewModel({required TaskRepository repository})
      : _repository = repository {
    loadTasks();
  }

  final TaskRepository _repository;

  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  int get pendingTasksCount => _tasks.where((t) => !t.isCompleted).length;

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    _tasks = await _repository.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Task getTaskById(int id) {
    return _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception('Tarea no encontrada'),
    );
  }
}
