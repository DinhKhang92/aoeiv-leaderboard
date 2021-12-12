import 'package:aoeiv_leaderboard/cubit/leaderboard_data_cubit.dart';
import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'leaderboard_data_cubit_test.mocks.dart';

@GenerateMocks([LeaderboardDataRepository])
void main() {
  group("LeaderboardDataCubit", () {
    final MockLeaderboardDataRepository _mockLeaderboardDataRepository = MockLeaderboardDataRepository();
    late LeaderboardDataCubit _leaderboardDataCubit;

    const int leaderboardId = 17;

    final Player examplePlayer = Player(rank: 1412, name: "T0nb3rry", totalGames: 100, totalWins: 71, totalLosses: 29, mmr: 1412, profileId: 1412);

    setUp(() {
      _leaderboardDataCubit = LeaderboardDataCubit(_mockLeaderboardDataRepository);
    });

    blocTest<LeaderboardDataCubit, LeaderboardDataState>(
      'emits LeaderboardDataLoading and LeaderboardDataLoaded when fetching leaderboard data succeeded',
      build: () {
        when(_mockLeaderboardDataRepository.fetchLeaderboardData(any)).thenAnswer((_) async => [examplePlayer]);

        return _leaderboardDataCubit;
      },
      act: (cubit) => cubit.fetchLeaderboardData(leaderboardId),
      expect: () => [isA<LeaderboardDataLoading>(), isA<LeaderboardDataLoaded>()],
    );
    blocTest<LeaderboardDataCubit, LeaderboardDataState>(
      'emits LeaderboardDataLoading and LeaderboardDataError when fetching leaderboard data failed',
      build: () {
        when(_mockLeaderboardDataRepository.fetchLeaderboardData(any)).thenThrow(Error());

        return _leaderboardDataCubit;
      },
      act: (cubit) => cubit.fetchLeaderboardData(leaderboardId),
      expect: () => [isA<LeaderboardDataLoading>(), isA<LeaderboardDataError>()],
    );
  });
}
