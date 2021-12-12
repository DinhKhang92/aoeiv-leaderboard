import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:http/http.dart';

class LeaderboardDataProvider {
  final Client _client = Client();
  final Config _config = Config();

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=1&count=${_config.maxCount}";
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map jsonData = jsonDecode(response.body);
      final List leaderboardData = jsonData['leaderboard'];

      final List<Player> playerList = _parsePlayers(leaderboardData);

      return playerList;
    }

    throw Exception("Failed to fetch leaderboard data with url: $url");
  }

  List<Player> _parsePlayers(List leaderboardData) {
    final List<Player> playerList = [];
    for (Map leaderboard in leaderboardData) {
      Player player = Player.fromJson(leaderboard);
      player.setWinRate = (player.totalWins / player.totalGames * 100).round();

      playerList.add(player);
    }
    return playerList;
  }

  Future<List<Player>> searchPlayer(int leaderboardId, String playerName) async {
    final String url = "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&search=$playerName&count=${_config.maxCount}";
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map jsonData = jsonDecode(response.body);
      final List leaderboardData = jsonData['leaderboard'];

      final List<Player> playerList = _parsePlayers(leaderboardData);

      return playerList;
    }

    throw Exception("Failed to fetch searched player with url: $url");
  }
}
