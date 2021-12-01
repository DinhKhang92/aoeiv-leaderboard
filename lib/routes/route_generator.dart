import 'package:aoeiv_leaderboard/pages/disclaimer_page.dart';
import 'package:aoeiv_leaderboard/pages/landing_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case '/disclaimer':
        return MaterialPageRoute(builder: (_) => const DisclaimerPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const LandingPage());
  }
}
