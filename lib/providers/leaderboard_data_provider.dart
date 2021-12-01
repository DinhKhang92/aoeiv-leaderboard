import 'dart:convert';

import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:http/http.dart' as http;

class LeaderboardDataProvider {
  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    final String url = 'https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=$leaderboardId&start=1&count=20';
    final List<Player> playerList = [];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map jsonData = jsonDecode(response.body);
      final List leaderboardData = jsonData['leaderboard'];
      for (Map leaderboard in leaderboardData) {
        Player player = Player.fromJson(leaderboard);
        player.setWinRate = (player.totalWins / player.totalGames * 100).round();

        playerList.add(player);
      }

      return playerList;
    }

    throw Exception('Failed to fetch leaderboard data with url: $url');
  }
}
