import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:http/http.dart';

class LeaderboardDataRepository {
  final LeaderboardDataProvider leaderboardDataProvider;
  final Config _config = Config();
  final Client _client = Client();

  LeaderboardDataRepository({required this.leaderboardDataProvider});

  Future<List<Player>> fetchLeaderboardData(String leaderboard) async {
    final String url = "${_config.leaderboardBaseUrl}/$leaderboard";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    return _parsePlayers(jsonData);
  }

  Future<List<Player>> searchPlayer(String leaderboard, String playerName) async {
    if (playerName.isEmpty) {
      return [];
    }

    final String url = "${_config.leaderboardBaseUrl}/$leaderboard?query=$playerName";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    return _parsePlayers(jsonData);
  }

  List<Player> _parsePlayers(Map jsonData) {
    final List leaderboardData = jsonData['players'];
    return leaderboardData.map((leaderboard) => Player.fromJson(leaderboard)).toList();
  }
}
