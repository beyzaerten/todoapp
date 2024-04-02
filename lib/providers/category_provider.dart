import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/utils/task_categories.dart';

final categoryProvider = StateProvider<TaskCategories>((ref) {
  return TaskCategories.others;
});
