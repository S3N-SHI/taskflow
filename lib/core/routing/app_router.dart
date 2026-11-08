import 'package:go_router/go_router.dart';
import '../../features/tasks/presentation/task_detail_view.dart';
import '../../features/tasks/presentation/task_list_view.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TaskListView(),
    ),
    GoRoute(
      path: '/task/:id',
      builder: (context, state) {
        final taskId = int.parse(state.pathParameters['id']!);
        return TaskDetailView(taskId: taskId);
      },
    ),
  ],
);
