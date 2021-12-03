import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/pages/disclaimer_page.dart';
import 'package:aoeiv_leaderboard/pages/landing_page.dart';
import 'package:aoeiv_leaderboard/pages/player_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case '/disclaimer':
        return MaterialPageRoute(builder: (_) => const DisclaimerPage());
      case '/player':
        return MaterialPageRoute(builder: (_) => PlayerPage(player: settings.arguments as Player));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const LandingPage());
  }
}
