import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getShowTutorial(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool showTutorial = prefs.getBool(key) ?? true;
  return showTutorial;
}

Future<void> setShowTutorial(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, false);
}
