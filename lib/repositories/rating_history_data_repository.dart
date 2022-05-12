import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';
import 'package:http/http.dart';

class RatingHistoryDataRepository {
  final Client _client = Client();
  final Config _config = Config();
  final RatingHistoryDataProvider ratingHistoryDataProvider;
  final LeaderboardDataProvider leaderboardDataProvider;

  RatingHistoryDataRepository({required this.ratingHistoryDataProvider, required this.leaderboardDataProvider});

  Future<List<Rating>> fetchRatingHistoryData(int leaderboardId, int profileId) async {
    final String url = "${_config.ratingHistoryBaseUrl}&leaderboard_id=$leaderboardId&profile_id=$profileId&count=${_config.leaderboardCount}";
    final List jsonData = await ratingHistoryDataProvider.fetchRatingHistoryData(_client, url);

    final List<Rating> ratingHistoryData = jsonData.map((ratingHistory) => Rating.fromJSON(ratingHistory)).toList();

    if (ratingHistoryData.isEmpty) {
      throw (NoDataException("No data found"));
    }

    return ratingHistoryData;
  }

  Future<Player> fetchPlayerDataByProfileId(int profileId) async {
    final String url = "${_config.playerStatsBaseUrl}/$profileId";
    final Map jsonData = await leaderboardDataProvider.fetchLeaderboardData(_client, url);

    final String name = jsonData["name"];
    final Map leaderboardData = jsonData['modes'];
    print(leaderboardData);
    leaderboardData.forEach((key, value) {
      print(key);
    });
    final List<Player> playerList = [];
    // final List<Player> playerList = leaderboardData.map((leaderboard) => Player.fromJson(leaderboard)).toList();

    if (playerList.isEmpty) {
      throw NoDataException("No player data found for profileId: $profileId with url :$url");
    }

    return playerList.first;
  }
}
