import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const TaskFlowApp());
}

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
  });

  final int id;
  final String title;
  final String description;
  final String priority;
  final bool isCompleted;
}

const demoTasks = [
  Task(
    id: 1,
    title: 'Leer documentación',
    description: 'Revisar ListView.builder y GoRouter',
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

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TaskListScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.parse(state.pathParameters['id']!);
        return TaskDetailScreen(taskId: taskId);
      },
    ),
  ],
);

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demoTasks.length,
        itemBuilder: (context, index) {
          final task = demoTasks[index];
          return TaskCard(
            task: task,
            onTap: () => context.push('/task/${task.id}'),
          );
        },
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
  });

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : null,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('${task.priority} · ${task.description}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context) {
    final task = demoTasks.firstWhere((item) => item.id == taskId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de tarea'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Chip(
              avatar: const Icon(Icons.flag_outlined, size: 18),
              label: Text('Prioridad: ${task.priority}'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  task.isCompleted ? Icons.check_circle : Icons.pending_actions,
                  color: task.isCompleted ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  task.isCompleted ? 'Estado: Completada' : 'Estado: Pendiente',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al listado'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
