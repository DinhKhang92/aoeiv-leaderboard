import 'package:aoeiv_leaderboard/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      // for android
      statusBarIconBrightness: Brightness.light,
      // for iOS
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}
