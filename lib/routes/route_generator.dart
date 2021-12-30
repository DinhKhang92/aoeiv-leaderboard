import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/pages/disclaimer_page.dart';
import 'package:aoeiv_leaderboard/pages/landing_page.dart';
import 'package:aoeiv_leaderboard/pages/player_page.dart';
import 'package:aoeiv_leaderboard/pages/splash_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/landing':
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case '/disclaimer':
        return MaterialPageRoute(builder: (_) => const DisclaimerPage());
      case '/player':
        final RatingHistoryScreenArgs args = settings.arguments as RatingHistoryScreenArgs;
        return MaterialPageRoute(
          builder: (_) => PlayerPage(
            player: args.player,
            leaderboardId: args.leaderboardId,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const LandingPage());
  }
}
