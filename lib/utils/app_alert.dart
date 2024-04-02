import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/providers/task/task_provider.dart';
import 'package:todoapp/utils/extensions.dart';

class AppAlert {
  AppAlert._();

  static displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.surface),
        ),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }

  static Future<void> showDeleteAlertDialog(
      BuildContext context, WidgetRef ref, Task task) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text("HAYIR"),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task).then((value) {
          displaySnackBar(context, "Görev silindi");
          context.pop();
        });
      },
      child: const Text("EVET"),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Bu görevi silmek istediğinize emin misiniz?"),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
