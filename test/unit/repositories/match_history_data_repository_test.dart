import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/providers/match_history_data_provider.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'match_history_data_repository_test.mocks.dart';
import '../../test_utils.dart';

@GenerateMocks([MatchHistoryDataProvider])
void main() {
  final MockMatchHistoryDataProvider _mockMatchHistoryDataProvider = MockMatchHistoryDataProvider();
  final MatchHistoryDataRepository _matchHistoryDataRepository = MatchHistoryDataRepository(matchHistoryDataProvider: _mockMatchHistoryDataProvider);

  group("MatchHistoryDataRepository", () {
    test("should fetch match history data", () async {
      const String url = "https://aoeiv.net/api/player/matches?game=aoe4&profile_id=123123&count=1000";
      final Match matchOne = Match.fromJSON(exampleMatchHistoryData[0]);
      final Match matchTwo = Match.fromJSON(exampleMatchHistoryData[1]);

      when(_mockMatchHistoryDataProvider.fetchMatchHistoryData(any, url)).thenAnswer((_) async => exampleMatchHistoryData);

      List<Match> matchHistoryData = await _matchHistoryDataRepository.fetchMatchHistoryData(123123);
      expect(matchHistoryData, [matchOne, matchTwo]);
    });
    test("should filter matches by the game mode", () async {
      final Match matchOneVOne = Match.fromJSON(exampleOneVOneMatch);
      final Match matchTwoVTwo = Match.fromJSON(exampleTwoVTwoMatch);
      final List<Match> matches = [matchOneVOne, matchTwoVTwo];

      List<Match> filteredMatches = _matchHistoryDataRepository.filterMatches(17, matches);
      expect(filteredMatches, [matchOneVOne]);
    });
    test("should get civ distribution based on played matches", () async {
      final Match matchOneVOne = Match.fromJSON(exampleOneVOneMatch);
      final Match matchTwoVTwo = Match.fromJSON(exampleTwoVTwoMatch);
      final List<Match> matches = [matchOneVOne, matchTwoVTwo];

      Map<String, int> civDistribution = _matchHistoryDataRepository.getCivDistributionByProfileId(matches, 5150581);
      expect(civDistribution, {"0": 0, "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 2, "7": 0});
    });
  });
}
