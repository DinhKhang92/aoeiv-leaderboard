import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:http/http.dart';

class LeaderboardDataProvider {
  Future<Map> fetchLeaderboardData(Client client, String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    throw FetchDataException("Error ${response.statusCode}. Failed to fetch leaderboard data with url: $url");
  }
}
