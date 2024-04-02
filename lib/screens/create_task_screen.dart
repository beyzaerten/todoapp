import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/config/routes/route_location.dart';
import 'package:todoapp/data/models/task.dart';
import 'package:todoapp/providers/category_provider.dart';
import 'package:todoapp/providers/date_provider.dart';
import 'package:todoapp/providers/task/task_provider.dart';
import 'package:todoapp/providers/time_provider.dart';
import 'package:todoapp/utils/app_alert.dart';
import 'package:todoapp/utils/helpers.dart';
import 'package:todoapp/widgets/common_text_field.dart';
import 'package:todoapp/widgets/display_white_text.dart';
import 'package:todoapp/widgets/select_category.dart';
import 'package:todoapp/widgets/select_date_time.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteText(text: "Yeni Görev Ekle"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: "Görev Başlığı",
                hintText: "Görev Başlığı",
                controller: _titleController,
              ),
              const Gap(16),
              SelectCategory(),
              const Gap(16),
              const SelectDateTime(),
              const Gap(16),
              CommonTextField(
                title: "Not",
                hintText: "Görev Notu",
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(60),
              ElevatedButton(
                  onPressed: () {
                    _createTask();
                  },
                  child: const DisplayWhiteText(text: "Kaydet"))
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
          title: title,
          note: note,
          time: Helpers.timeToString(time),
          date: DateFormat.yMMMd().format(date),
          category: category,
          isCompleted: false);

      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        AppAlert.displaySnackBar(context, "Görev başarıyla oluşturuldu");
        context.go(RouteLocation.home);
      });
    } else {
      AppAlert.displaySnackBar(context, "Görev başlığı boş olamaz");
    }
  }
}
