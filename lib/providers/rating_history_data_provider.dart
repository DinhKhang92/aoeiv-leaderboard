import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:http/http.dart' as http;

class RatingHistoryDataProvider {
  final Config _config = Config();

  Future<List<Rating>> fetchRatingHistoryData(int leaderboardId, int profileId) async {
    final String ratingHistoryUrl = "${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId&profile_id=$profileId&count=${_config.maxCount}";
    final List<Rating> ratingList = [];

    final response = await http.get(Uri.parse(ratingHistoryUrl));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);

      for (Map ratingHistory in jsonData) {
        final Rating rating = Rating.fromJSON(ratingHistory);

        ratingList.add(rating);
      }
      return ratingList;
    }

    throw Exception('Failed to fetch rating history data with url: ${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId}');
  }
}
