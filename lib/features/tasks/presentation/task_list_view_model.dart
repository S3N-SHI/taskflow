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
  String? _errorMessage;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get lastStatusCode => _repository.lastStatusCode;

  bool get isEmpty => !_isLoading && _errorMessage == null && _tasks.isEmpty;
  bool get hasError => _errorMessage != null;

  Future<void> loadTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tasks = await _repository.getTasks();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _tasks = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Task getTaskById(int id) {
    return _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => throw Exception('Tarea con ID $id no encontrada'),
    );
  }
}
