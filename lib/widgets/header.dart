import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String headerTitle;
  final Widget? trailing;
  const Header({required this.headerTitle, this.trailing, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back_ios),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Spacing.l.value),
            child: Text(
              headerTitle,
              style: Theme.of(context).textTheme.headline1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        trailing ?? const SizedBox(width: 24),
      ],
    );
  }
}
