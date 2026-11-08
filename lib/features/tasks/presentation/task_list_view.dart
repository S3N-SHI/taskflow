import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'task_list_view_model.dart';
import 'widgets/task_card.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Actualizar tareas',
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TaskListViewModel>().loadTasks(),
          ),
        ],
      ),
      body: Consumer<TaskListViewModel>(
        builder: (context, viewModel, child) {
          // 1. Estado de Carga
          if (viewModel.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Consultando API remota...'),
                ],
              ),
            );
          }

          // 2. Estado de Error
          if (viewModel.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off,
                        size: 64, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      'Ocurrió un error al cargar:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () => viewModel.loadTasks(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Estado Vacío
          if (viewModel.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No hay tareas registradas en el servidor.'),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => viewModel.loadTasks(),
                    child: const Text('Actualizar'),
                  ),
                ],
              ),
            );
          }

          // 4. Estado Exitoso con lista remota y RefreshIndicator
          return RefreshIndicator(
            onRefresh: () => viewModel.loadTasks(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.tasks.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tareas obtenidas: ${viewModel.tasks.length}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        if (viewModel.lastStatusCode != null)
                          Chip(
                            avatar: const Icon(Icons.http, size: 18),
                            label: Text('HTTP ${viewModel.lastStatusCode} OK'),
                            backgroundColor: const Color(0x264CAF50),
                            side: BorderSide.none,
                          ),
                      ],
                    ),
                  );
                }

                final task = viewModel.tasks[index - 1];
                return TaskCard(
                  task: task,
                  onTap: () => context.push('/task/${task.id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
