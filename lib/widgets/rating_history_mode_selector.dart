import 'package:flutter/material.dart';

class RatingHistoryModeSelector extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  const RatingHistoryModeSelector({required this.label, required this.labelColor, required this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
      child: Text(label, style: TextStyle(color: labelColor)),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}