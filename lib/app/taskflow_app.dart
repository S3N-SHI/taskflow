import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/app_theme.dart';
import '../features/tasks/presentation/task_detail_screen.dart';
import '../features/tasks/presentation/task_form_screen.dart';
import '../features/tasks/presentation/task_list_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TaskListScreen(),
    ),
    GoRoute(
      path: '/new',
      builder: (context, state) => const TaskFormScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) => TaskDetailScreen(
        taskId: int.tryParse(state.pathParameters['id'] ?? ''),
      ),
    ),
  ],
);

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TaskFlow',
      theme: appTheme,
      routerConfig: _router,
    );
  }
}
