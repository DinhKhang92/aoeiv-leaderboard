import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';

class RatingHistoryDataRepository {
  final RatingHistoryDataProvider _ratingHistoryDataProvider = RatingHistoryDataProvider();

  Future<List<Rating>> fetchRatingHistoryData(int leaderboardId, int profileId) => _ratingHistoryDataProvider.fetchRatingHistoryData(leaderboardId, profileId);
}
