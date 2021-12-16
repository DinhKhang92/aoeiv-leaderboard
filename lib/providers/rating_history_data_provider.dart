import 'dart:convert';

import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:http/http.dart';

class RatingHistoryDataProvider {
  final Config _config = Config();

  Future<List<Rating>> fetchRatingHistoryData(Client client, int leaderboardId, int profileId) async {
    final String url = "${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId&profile_id=$profileId&count=${_config.maxCount}";

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);

      return jsonData.map((ratingHistory) => Rating.fromJSON(ratingHistory)).toList();
    }

    throw FetchDataException('Error ${response.statusCode}. Failed to fetch rating history data with url: $url');
  }
}
