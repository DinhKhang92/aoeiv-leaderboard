import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/pages/disclaimer_page/disclaimer_page.dart';
import 'package:aoeiv_leaderboard/pages/landing_page/landing_page.dart';
import 'package:aoeiv_leaderboard/pages/player_page/player_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String landingPage = '/';
  static const String disclaimerPage = '/disclaimer';
  static const String playerDetailsPage = '/player';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingPage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case Routes.disclaimerPage:
        return MaterialPageRoute(builder: (_) => const DisclaimerPage());
      case Routes.playerDetailsPage:
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
