import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String errorMessage;
  const ErrorDisplay({required this.errorMessage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning, size: 30),
          SizedBox(height: Spacing.xs.value),
          Text(errorMessage),
        ],
      ),
    );
  }
}
