import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/models/match_player.dart';
import 'package:http/http.dart';

class MatchHistoryDataProvider {
  final Config _config = Config();
  final Client _client = Client();

  Future<List<Match>> fetchMatchHistoryData(int profileId) async {
    final String url = "${_config.matchHistoryBaseUrl}&profile_id=$profileId&count=${_config.maxCount}";

    final List<Match> matchList = [];
    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);

      for (Map matchHistory in jsonData) {
        final List<MatchPlayer> matchPlayers = matchHistory['players'].map((matchHistoryPlayer) => MatchPlayer.fromJSON(matchHistoryPlayer)).toList();

        final Match match = Match.fromJSON(matchHistory);
        match.setMatchPlayers = matchPlayers;

        matchList.add(match);
      }
      return matchList;
    }

    throw FetchDataException('Error ${response.statusCode}. Failed to fetch match history data with url: $url');
  }
}
