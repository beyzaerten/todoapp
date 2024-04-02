import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer(
      {Key? key, required this.color, this.child, this.border})
      : super(key: key);
  final Color color;
  final Widget? child;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color, border: border),
      child: Center(child: child),
    );
  }
}
