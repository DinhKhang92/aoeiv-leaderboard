import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:flutter/material.dart';

class RatingHistoryModeSelector extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  const RatingHistoryModeSelector({required this.label, required this.labelColor, required this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.xs.spacing),
      margin: EdgeInsets.symmetric(horizontal: Spacing.xxs.spacing),
      child: Text(
        label,
        style: TextStyle(color: labelColor),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(kbBorderRadius)),
      ),
    );
  }
}
