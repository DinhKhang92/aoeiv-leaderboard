import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:flutter/material.dart';

const TextSelectionThemeData ktTextSelectionTheme = TextSelectionThemeData(
  cursorColor: kcTertiaryColor,
);

const InputDecorationTheme ktInputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(fontSize: 12, color: kcHintColor),
  contentPadding: EdgeInsets.symmetric(horizontal: 10),
  border: InputBorder.none,
);

const TextTheme ktTextTheme = TextTheme(
  headline1: TextStyle(
    color: kcPrimaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
  headline2: TextStyle(
    color: kcUnselectedColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  bodyText1: TextStyle(
    color: kcColorWhite,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  bodyText2: TextStyle(
    color: kcColorWhite,
    fontSize: 14,
  ),
);

const IconThemeData ktIconThemeData = IconThemeData(
  color: kcPrimaryColor,
);

const BottomNavigationBarThemeData ktBottomNavigationBarTheme = BottomNavigationBarThemeData(
  elevation: 0,
  showUnselectedLabels: true,
  selectedItemColor: kcPrimaryColor,
  unselectedItemColor: kcUnselectedColor,
  backgroundColor: kcColorTransparent,
  type: BottomNavigationBarType.fixed,
);
