import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/providers/category_provider.dart';
import 'package:todoapp/utils/extensions.dart';
import 'package:todoapp/utils/task_categories.dart';
import 'package:todoapp/widgets/circle_container.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final categories = TaskCategories.values.toList();
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            "Kategori",
            style: context.textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
              child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return InkWell(
                        onTap: () {
                          ref.read(categoryProvider.notifier).state = category;
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: CircleContainer(
                          border: category == selectedCategory
                              ? Border.all(width: 3, color: Colors.black)
                              : Border.all(width: 2, color: category.color),
                          color: category.color.withOpacity(0.3),
                          child: Icon(category.icon, color: category.color),
                        ));
                  },
                  separatorBuilder: (context, index) => Gap(8),
                  itemCount: categories.length))
        ],
      ),
    );
  }
}
