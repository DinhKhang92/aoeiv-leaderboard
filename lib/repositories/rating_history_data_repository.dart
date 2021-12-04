import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';

class RatingHistoryDataRepository {
  final RatingHistoryDataProvider _ratingHistoryDataProvider = RatingHistoryDataProvider();

  Future<List<int>> fetchRatingHistoryData(int leaderboardId, int profileId) => _ratingHistoryDataProvider.fetchRatingHistoryData(leaderboardId, profileId);
}