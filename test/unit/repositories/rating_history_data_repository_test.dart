import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/providers/rating_history_data_provider.dart';
import 'package:aoeiv_leaderboard/repositories/rating_history_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';
import 'rating_history_data_repository_test.mocks.dart';

@GenerateMocks([RatingHistoryDataProvider, LeaderboardDataProvider])
void main() {
  final MockRatingHistoryDataProvider _mockRatingHistoryDataProvider = MockRatingHistoryDataProvider();
  final MockLeaderboardDataProvider _mockLeaderboardDataProvider = MockLeaderboardDataProvider();
  final RatingHistoryDataRepository _ratingHistoryDataRepository =
      RatingHistoryDataRepository(ratingHistoryDataProvider: _mockRatingHistoryDataProvider, leaderboardDataProvider: _mockLeaderboardDataProvider);

  group("RatingHistoryDataRepository", () {
    test("should fetch rating history data", () async {
      const String url = "https://aoeiv.net/api/player/ratinghistory?game=aoe4&leaderboard_id=17&profile_id=123123&count=1000";
      final Rating firstRatingDataPoint = Rating.fromJSON(exampleRatingHistoryData[0]);
      final Rating secondRatingDataPoint = Rating.fromJSON(exampleRatingHistoryData[1]);

      when(_mockRatingHistoryDataProvider.fetchRatingHistoryData(any, url)).thenAnswer((_) async => exampleRatingHistoryData);
      final List<Rating> ratingHistoryData = await _ratingHistoryDataRepository.fetchRatingHistoryData(17, 123123);

      expect(ratingHistoryData, [firstRatingDataPoint, secondRatingDataPoint]);
    });
    test("should throw a no data exception if rating history data is empty", () async {
      const String url = "https://aoeiv.net/api/player/ratinghistory?game=aoe4&leaderboard_id=17&profile_id=123123&count=1000";

      when(_mockRatingHistoryDataProvider.fetchRatingHistoryData(any, url)).thenAnswer((_) async => []);

      expect(() async => await _ratingHistoryDataRepository.fetchRatingHistoryData(17, 123123), throwsA(isA<NoDataException>()));
    });
    test("should fetch leaderboard data of a single player using the profile id", () async {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&profile_id=123123";
      final Player expectedPlayer = Player.fromJson(exampleLeaderboardPlayerOne);
      when(_mockLeaderboardDataProvider.fetchLeaderboardData(any, url)).thenAnswer(
        (_) async => {
          ...exampleLeaderboardData,
          "leaderboard": [exampleLeaderboardPlayerOne]
        },
      );

      final Player playerData = await _ratingHistoryDataRepository.fetchPlayerDataByProfileId(17, 123123);

      expect(playerData, expectedPlayer);
    });
    test("should throw no data exception if no player data found", () async {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&profile_id=123123";
      when(_mockLeaderboardDataProvider.fetchLeaderboardData(any, url)).thenAnswer(
        (_) async => {...exampleLeaderboardData, "leaderboard": []},
      );

      expect(() async => await _ratingHistoryDataRepository.fetchPlayerDataByProfileId(17, 123123), throwsA(isA<NoDataException>()));
    });
  });
}
