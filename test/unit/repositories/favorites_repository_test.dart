import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/repositories/favorites_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';
import 'favorites_repository_test.mocks.dart';

@GenerateMocks([LeaderboardDataProvider])
void main() {
  final MockLeaderboardDataProvider _mockLeaderboardDataProvider = MockLeaderboardDataProvider();
  final FavoritesRepository _favoritesDataRepository = FavoritesRepository(leaderboardDataProvider: _mockLeaderboardDataProvider);

  group("FavoritesDataRepository", () {
    test("should fetch leaderboard data of a single player using the profile id", () async {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&profile_id=123123";
      final Player expectedPlayer = Player.fromJson(exampleLeaderboardPlayerOne);
      when(_mockLeaderboardDataProvider.fetchLeaderboardData(any, url)).thenAnswer(
        (_) async => {
          ...exampleLeaderboardData,
          "leaderboard": [exampleLeaderboardPlayerOne]
        },
      );

      final Player playerData = await _favoritesDataRepository.fetchLeaderboardDataByProfileId(17, 123123);

      expect(playerData, expectedPlayer);
    });
    test("should throw no data exception if no player data found", () async {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&profile_id=123123";
      when(_mockLeaderboardDataProvider.fetchLeaderboardData(any, url)).thenAnswer(
        (_) async => {...exampleLeaderboardData, "leaderboard": []},
      );

      expect(() async => await _favoritesDataRepository.fetchLeaderboardDataByProfileId(17, 123123), throwsA(isA<NoDataException>()));
    });
  });
}
