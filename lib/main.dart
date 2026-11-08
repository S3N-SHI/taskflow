import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routing/app_router.dart';
import 'features/tasks/data/task_repository.dart';
import 'features/tasks/presentation/task_list_view_model.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TaskRepository>(
          create: (_) => LocalTaskRepository(),
        ),
        ChangeNotifierProvider<TaskListViewModel>(
          create: (context) => TaskListViewModel(
            repository: context.read<TaskRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TaskFlow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
