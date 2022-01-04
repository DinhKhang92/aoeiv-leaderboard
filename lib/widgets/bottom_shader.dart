import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:flutter/material.dart';

class BottomShader extends StatelessWidget {
  final Widget child;
  const BottomShader({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.transparent, kcColorWhite],
          stops: [0.0, 0.04],
        ).createShader(rect);
      },
      child: child,
    );
  }
}
