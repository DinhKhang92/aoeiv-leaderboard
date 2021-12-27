import 'dart:convert';

import 'package:aoeiv_leaderboard/exceptions/fetch_data_exception.dart';
import 'package:http/http.dart';

class MatchHistoryDataProvider {
  Future<List> fetchMatchHistoryData(Client client, String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw FetchDataException('Error ${response.statusCode}. Failed to fetch match history data with url: $url');
  }
}
