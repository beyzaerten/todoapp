import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/providers/task/task_provider.dart';
import 'package:todoapp/utils/app_alert.dart';
import 'package:todoapp/utils/extensions.dart';
import 'package:todoapp/widgets/common_container.dart';
import 'package:todoapp/widgets/task_details.dart';
import 'package:todoapp/widgets/task_tile.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks(
      {Key? key, required this.tasks, this.isCompletedTasks = false})
      : super(key: key);
  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;

    final emptyTaskMessage = isCompletedTasks
        ? "Henüz tamamlanmış bir göreviniz yok."
        : "Yapılacak bir göreviniz yok!";

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.bodyLarge,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return InkWell(
                    onLongPress: () {
                      // TODO-Delete Task
                      AppAlert.showDeleteAlertDialog(context, ref, task);
                    },
                    onTap: () async {
                      // TODO-Show Task Details
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return TaskDetails(task: task);
                        },
                      );
                    },
                    child: TaskTile(
                      task: task,
                      onCompleted: (value) async {
                        await ref
                            .read(taskProvider.notifier)
                            .updateTask(task)
                            .then((value) {
                          AppAlert.displaySnackBar(
                              context,
                              task.isCompleted
                                  ? "Görev tamamlanmadı"
                                  : "Görev tamamlandı");
                        });
                      },
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
