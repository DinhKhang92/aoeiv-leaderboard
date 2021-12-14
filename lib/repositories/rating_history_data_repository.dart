import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';

class RatingHistoryDataRepository {
  final RatingHistoryDataProvider _ratingHistoryDataProvider = RatingHistoryDataProvider();
  final LeaderboardDataProvider _leaderboardDataProvider = LeaderboardDataProvider();

  Future<List<Rating>> fetchRatingHistoryData(int leaderboardId, int profileId) => _ratingHistoryDataProvider.fetchRatingHistoryData(leaderboardId, profileId);

  Future<Player> fetchPlayerDataByProfileId(int leaderboardId, int profileId) => _leaderboardDataProvider.fetchPlayerDataByProfileId(leaderboardId, profileId);
}
