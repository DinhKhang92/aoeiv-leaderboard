import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:flutter/material.dart';

class TutorialContent extends StatelessWidget {
  final String title;
  final String description;
  const TutorialContent({required this.title, required this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: Spacing.m.value),
        Text(
          description,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
