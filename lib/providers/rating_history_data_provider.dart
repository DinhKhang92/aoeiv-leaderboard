import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:http/http.dart';

class RatingHistoryDataProvider {
  final Config _config = Config();

  Future<List<Rating>> fetchRatingHistoryData(Client client, int leaderboardId, int profileId) async {
    final String url = "${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId&profile_id=$profileId&count=${_config.maxCount}";
    final List<Rating> ratingList = [];

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);

      for (Map ratingHistory in jsonData) {
        final Rating rating = Rating.fromJSON(ratingHistory);
        rating.setWinRate = (rating.totalWins / (rating.totalWins + rating.totalLosses) * 100).round();

        ratingList.add(rating);
      }
      return ratingList;
    }

    throw FetchDataException('Error ${response.statusCode}. Failed to fetch rating history data with url: $url');
  }
}
