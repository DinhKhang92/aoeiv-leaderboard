import 'package:aoeiv_leaderboard/models/player.dart';

class RatingHistoryScreenArgs {
  final int leaderboardId;
  final Player player;

  const RatingHistoryScreenArgs({required this.leaderboardId, required this.player});
}
