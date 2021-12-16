import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';
import 'package:http/http.dart';

class RatingHistoryDataRepository {
  final RatingHistoryDataProvider _ratingHistoryDataProvider = RatingHistoryDataProvider();
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();

  Future<List<Rating>> fetchRatingHistoryData(Client client, int leaderboardId, int profileId) =>
      _ratingHistoryDataProvider.fetchRatingHistoryData(client, leaderboardId, profileId);

  Future<Player> fetchPlayerDataByProfileId(int leaderboardId, int profileId) => _leaderboardDataProvider.fetchPlayerDataByProfileId(leaderboardId, profileId);
}
