import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:http/http.dart';

class LeaderboardDataRepository {
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();

  Future<List<Player>> fetchLeaderboardData(Client client, int leaderboardId) => _leaderboardDataProvider.fetchLeaderboardData(client, leaderboardId);

  Future<List<Player>> searchPlayer(Client client, int leaderboardId, String playerName) => _leaderboardDataProvider.searchPlayer(client, leaderboardId, playerName);
}
