import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:flutter/material.dart';

const double kbBorderRadius = 5.0;

final ThemeData ktTheme = ThemeData(
  textSelectionTheme: ktTextSelectionTheme,
  inputDecorationTheme: ktInputDecorationTheme,
  textTheme: ktTextTheme,
  iconTheme: ktIconThemeData,
  bottomNavigationBarTheme: ktBottomNavigationBarTheme,
);

const TextSelectionThemeData ktTextSelectionTheme = TextSelectionThemeData(
  cursorColor: kcTertiaryColor,
);

InputDecorationTheme ktInputDecorationTheme = InputDecorationTheme(
  hintStyle: const TextStyle(fontSize: 12, color: kcHintColor),
  contentPadding: EdgeInsets.symmetric(horizontal: Spacing.s.spacing),
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
  headline3: TextStyle(
    color: kcColorWhite,
    fontSize: 16,
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
