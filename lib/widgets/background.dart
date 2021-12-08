import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kcTertiaryColor,
            kcSecondaryColor,
          ],
        ),
      ),
    );
  }
}
