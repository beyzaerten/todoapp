import 'package:flutter/material.dart';

import 'package:todoapp/utils/extensions.dart';

class DisplayWhiteText extends StatelessWidget {
  const DisplayWhiteText({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
          color: context.colorScheme.surface,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: fontSize),
    );
  }
}
