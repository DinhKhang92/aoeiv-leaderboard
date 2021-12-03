import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:http/http.dart' as http;

class RatingHistoryDataProvider {
  final Config _config = Config();

  Future<List<int>> fetchRatingHistoryData(int leaderboardId, int profileId) async {
    final String ratingHistoryUrl = "${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId&profile_id=$profileId&count=${_config.maxCount}";
    final List<int> ratingList = [];

    final response = await http.get(Uri.parse(ratingHistoryUrl));

    if (response.statusCode == 200) {
      final Map jsonData = jsonDecode(response.body);
      final List ratingHistoryData = jsonData['leaderboard'];

      for (Map ratingHistory in ratingHistoryData) {
        final int rating = ratingHistory["rating"];

        ratingList.add(rating);
      }
    }

    throw Exception('Failed to fetch rating history data with url: ${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId}');
  }
}
