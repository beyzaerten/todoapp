import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/providers/date_provider.dart';
import 'package:todoapp/providers/time_provider.dart';
import 'package:todoapp/utils/helpers.dart';
import 'package:todoapp/widgets/common_text_field.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    // timeofdayi datetimea çeviriyoruz

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: "Tarih",
            hintText: DateFormat.yMMMd().format(date),
            suffixIcon: IconButton(
                onPressed: () {
                  Helpers.selectDate(context, ref);
                },
                icon: const FaIcon(FontAwesomeIcons.calendar)),
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            title: "Zaman",
            hintText: Helpers.timeToString(time),
            readOnly: true, // sadece tıklanılan şeyin çalışmasını sağladı
            suffixIcon: IconButton(
                onPressed: () {
                  _selectTime(context, ref);
                },
                icon: const FaIcon(FontAwesomeIcons.clock)),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    final initialTime = ref.watch(timeProvider);
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
} 
// yarın provider
