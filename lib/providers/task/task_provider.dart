import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/providers/task/task_notifier.dart';
import 'package:todoapp/providers/task/task_repository_provider.dart';
import 'package:todoapp/providers/task/task_state.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
