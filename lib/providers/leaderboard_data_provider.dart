import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:http/http.dart' as http;

class LeaderboardDataProvider {
  final Config _config = Config();

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    final int totalPlayerCount = await _getTotalPlayerCount("${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId").catchError((error) {
      throw Exception(error);
    });

    final List<Player> playerList = [];
    for (int i = 0; i < (totalPlayerCount / _config.maxCount).ceil(); i++) {
      final int start = 1 + i * _config.maxCount;
      final String url = '${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=$start&count=${_config.maxCount}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map jsonData = jsonDecode(response.body);
        final List leaderboardData = jsonData['leaderboard'];

        for (Map leaderboard in leaderboardData) {
          Player player = Player.fromJson(leaderboard);
          player.setWinRate = (player.totalWins / player.totalGames * 100).round();

          playerList.add(player);
        }
      } else {
        throw Exception('Failed to fetch leaderboard data with url: ${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId}');
      }
    }

    return playerList;
  }

  Future<int> _getTotalPlayerCount(String baseUrl) async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final Map jsonData = jsonDecode(response.body);
      final int totalPlayerCount = jsonData['total'];

      return totalPlayerCount;
    }

    throw Exception("Failed to fetch total player count with baseUrl: $baseUrl");
  }
}
