import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/providers/match_history_data_provider.dart';

class MatchHistoryDataRepository {
  final MatchHistoryDataProvider _matchHistoryDataProvider = MatchHistoryDataProvider();

  Future<List<Match>> fetchMatchHistoryData(int profileId) => _matchHistoryDataProvider.fetchMatchHistoryData(profileId);
}
