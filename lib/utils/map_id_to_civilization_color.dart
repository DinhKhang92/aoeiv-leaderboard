import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:flutter/material.dart';

Color mapIdToCivilizationColor(int id) {
  switch (id) {
    case 0:
      return kcAbbasidColor;
    case 1:
      return kcChineseColor;
    case 2:
      return kcDelhiColor;
    case 3:
      return kcEnglishColor;
    case 4:
      return kcFrenchColor;
    case 5:
      return kcHolyRomanColor;
    case 6:
      return kcMongolsColor;
    case 7:
      return kcRusColor;
    default:
      return Colors.transparent;
  }
}
