import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';

class LeaderboardDataRepository {
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) => _leaderboardDataProvider.fetchLeaderboardData(leaderboardId);

  Future<List<Player>> searchPlayer(int leaderboardId, String playerName) => _leaderboardDataProvider.searchPlayer(leaderboardId, playerName);
}
