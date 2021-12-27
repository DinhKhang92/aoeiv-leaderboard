import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/providers/leaderboard_data_provider.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_utils.dart';
import 'leaderboard_data_repository_test.mocks.dart';

@GenerateMocks([LeaderboardDataProvider])
void main() {
  final MockLeaderboardDataProvider _mockLeaderboardDataProvider = MockLeaderboardDataProvider();
  final LeaderboardDataRepository _leaderboardDataRepository = LeaderboardDataRepository(leaderboardDataProvider: _mockLeaderboardDataProvider);

  group("LeaderboardDataRepository", () {
    test('should fetch leaderboard data of all players', () async {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&start=1&count=1000";

      when(_mockLeaderboardDataProvider.fetchLeaderboardData(any, url)).thenAnswer((_) async => exampleLeaderboardData);
      final Player firstPlayer = Player.fromJson(exampleLeaderboardData["leaderboard"][0]);
      final Player secondPlayer = Player.fromJson(exampleLeaderboardData["leaderboard"][1]);
      List<Player> leaderboardData = await _leaderboardDataRepository.fetchLeaderboardData(17);

      expect([firstPlayer, secondPlayer], leaderboardData);
    });
    test('should fetch leaderboard data of searched players', () async {
      const String url = "https://aoeiv.net/api/leaderboard?game=aoe4&leaderboard_id=17&search=GojirA&count=1000";

      when(_mockLeaderboardDataProvider.fetchLeaderboardData(any, url)).thenAnswer(
        (_) async => {
          ...exampleLeaderboardData,
          "leaderboard": [exampleLeaderboardPlayerOne]
        },
      );
      final Player searchedPlayer = Player.fromJson(exampleLeaderboardData["leaderboard"][0]);
      List<Player> leaderboardData = await _leaderboardDataRepository.searchPlayer(17, "GojirA");

      expect([searchedPlayer], leaderboardData);
    });
  });
}
