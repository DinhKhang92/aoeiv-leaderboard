import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';

class LeaderboardDataRepository {
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();

  Future<List<Player>> fetchLeaderboardData() => _leaderboardDataProvider.fetchLeaderboardData();
}
