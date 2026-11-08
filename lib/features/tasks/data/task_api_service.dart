import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/task.dart';

class TaskApiService {
  TaskApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  int? lastStatusCode;

  Future<List<Task>> fetchTasks() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/todos?_limit=10'),
    );

    lastStatusCode = response.statusCode;

    if (response.statusCode != 200) {
      throw Exception('Error del servidor: HTTP ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data.map((json) {
      final map = json as Map<String, dynamic>;
      final id = map['id'] as int;
      final priority = id % 3 == 0 ? 'Alta' : (id % 2 == 0 ? 'Media' : 'Baja');

      return Task(
        id: id,
        title: map['title'] as String,
        description: 'Tarea sincronizada desde API REST externa',
        priority: priority,
        isCompleted: map['completed'] as bool? ?? false,
      );
    }).toList();
  }
}
