import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:http/http.dart';

class LeaderboardDataRepository {
  final LeaderboardDataProvider leaderboardDataProvider;
  final Config _config = Config();
  final Client _client = Client();

  LeaderboardDataRepository({required this.leaderboardDataProvider});

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=1&count=${_config.leaderboardCount}";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    return _parsePlayers(jsonData);
  }

  Future<List<Player>> searchPlayer(int leaderboardId, String playerName) async {
    if (playerName.isEmpty) {
      return [];
    }

    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&search=$playerName&count=${_config.leaderboardCount}";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    return _parsePlayers(jsonData);
  }

  List<Player> _parsePlayers(Map jsonData) {
    final List leaderboardData = jsonData['leaderboard'];
    return leaderboardData.map((leaderboard) => Player.fromJson(leaderboard)).toList();
  }
}
