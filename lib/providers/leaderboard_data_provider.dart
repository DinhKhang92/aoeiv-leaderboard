import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class LeaderboardDataProvider {
  final Client _client = Client();
  final Config _config = Config();

  Future<List<Player>> fetchLeaderboardData(int leaderboardId) async {
    final Map initData = await _getDataFromInitRequest(_client, "${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=1&count=${_config.maxCount}");
    final int totalPlayerCount = initData["totalPlayerCount"];
    List<Player> playerList = initData["playerList"];

    for (int index = 1; index < (totalPlayerCount / _config.maxCount).ceil(); index++) {
      final int start = 1 + index * _config.maxCount;
      final String url = '${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId&start=$start&count=${_config.maxCount}';
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map jsonData = jsonDecode(response.body);
        final List leaderboardData = jsonData['leaderboard'];

        final List<Player> parsedPlayerList = await compute(_parsePlayer, leaderboardData);
        playerList = [...playerList, ...parsedPlayerList];
      } else {
        throw Exception('Failed to fetch leaderboard data with url: ${_config.leaderboardBaseUrl}&leaderboard_id=$leaderboardId}');
      }
    }

    return playerList;
  }

  Future<Map> _getDataFromInitRequest(Client client, String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map jsonData = jsonDecode(response.body);
      final int totalPlayerCount = jsonData['total'];
      final List leaderboardData = jsonData['leaderboard'];

      final List<Player> playerList = await compute(_parsePlayer, leaderboardData);

      return {
        "totalPlayerCount": totalPlayerCount,
        "playerList": playerList,
      };
    }

    throw Exception("Failed to fetch total player count with baseUrl: $url");
  }

  static List<Player> _parsePlayer(List leaderboardData) {
    final List<Player> playerList = [];
    for (Map leaderboard in leaderboardData) {
      Player player = Player.fromJson(leaderboard);
      player.setWinRate = (player.totalWins / player.totalGames * 100).round();

      playerList.add(player);
    }
    return playerList;
  }
}
