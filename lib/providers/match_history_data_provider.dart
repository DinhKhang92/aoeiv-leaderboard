import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:http/http.dart';

class MatchHistoryDataProvider {
  final Config _config = Config();
  final Client _client = Client();

  Future<List<Match>> fetchMatchHistoryData(int profileId) async {
    final String url = "${_config.matchHistoryBaseUrl}&profile_id=$profileId&count=${_config.matchHistoryMaxCount}";

    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);

      return jsonData.map((matchHistory) => Match.fromJSON(matchHistory)).toList();
    }

    throw FetchDataException('Error ${response.statusCode}. Failed to fetch match history data with url: $url');
  }
}
