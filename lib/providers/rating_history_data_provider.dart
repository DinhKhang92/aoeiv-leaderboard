import 'dart:convert';

import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:http/http.dart';

class RatingHistoryDataProvider {
  Future<List> fetchRatingHistoryData(Client _client, String url) async {
    final response = await _client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw FetchDataException('Error ${response.statusCode}. Failed to fetch rating history data with url: $url');
  }
}
