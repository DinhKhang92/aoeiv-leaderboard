import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String headerTitle;

  const Header({required this.headerTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back_ios),
        ),
        Text(
          headerTitle,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
