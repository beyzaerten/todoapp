import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/utils/extensions.dart';
import 'package:todoapp/widgets/circle_container.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;

    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          CircleContainer(
            border: Border.all(width: 2, color: task.category.color),
            color: task.category.color.withOpacity(0.3),
            child: Icon(
              task.category.icon,
              color: task.category.color,
            ),
          ),
          const Gap(16),
          Text(
            task.title,
            style: style.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            task.time,
            style: style.titleMedium,
          ),
          const Gap(16),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Görev ${task.date} tarihinde tamamlanacak"),
                Icon(
                  Icons.check_box,
                  color: task.category.color,
                )
              ],
            ),
          ),
          const Gap(16),
          Divider(
            thickness: 1.5,
            color: task.category.color,
          ),
          const Gap(16),
          Text(task.note.isEmpty
              ? "Bu görev için herhangi bir not bulunmamaktadır"
              : task.note),
          const Gap(16),
          Visibility(
            visible: task.isCompleted,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Görev tamamlandı"),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
