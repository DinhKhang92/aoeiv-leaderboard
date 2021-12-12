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
      _leaderboardDataCubit = LeaderboardDataCubit(leaderboardDataRepository: _mockLeaderboardDataRepository);
    });

    group("fetchLeaderboardData", () {
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
        'emits LeaderboardDataLoading and LeaderboardDataLoaded with player data when fetching data succeeded',
        build: () {
          when(_mockLeaderboardDataRepository.fetchLeaderboardData(any)).thenAnswer((_) async => [examplePlayer]);

          return _leaderboardDataCubit;
        },
        act: (cubit) => cubit.fetchLeaderboardData(leaderboardId),
        expect: () => [
          const LeaderboardDataLoading(leaderboardData: [], searchedPlayers: []),
          LeaderboardDataLoaded(leaderboardData: [examplePlayer], searchedPlayers: const [])
        ],
      );
      blocTest<LeaderboardDataCubit, LeaderboardDataState>(
        'emits LeaderboardDataLoading and LeaderboardDataError when fetching leaderboard data failed',
        build: () {
          when(_mockLeaderboardDataRepository.fetchLeaderboardData(any)).thenThrow(Error);

          return _leaderboardDataCubit;
        },
        act: (cubit) => cubit.fetchLeaderboardData(leaderboardId),
        expect: () => [isA<LeaderboardDataLoading>(), isA<LeaderboardDataError>()],
      );
    });

    group("searchPlayer", () {
      blocTest<LeaderboardDataCubit, LeaderboardDataState>(
        'emits LeaderboardDataLoading and LeaderboardDataLoaded when searching player succeeded',
        build: () {
          when(_mockLeaderboardDataRepository.searchPlayer(any, any)).thenAnswer((_) async => [examplePlayer]);

          return _leaderboardDataCubit;
        },
        act: (cubit) => cubit.searchPlayer(leaderboardId, "t0nb"),
        expect: () => [isA<LeaderboardDataLoading>(), isA<LeaderboardDataLoaded>()],
      );
      blocTest<LeaderboardDataCubit, LeaderboardDataState>(
        'emits LeaderboardDataLoading and LeaderboardDataLoaded with player data when player found',
        build: () {
          when(_mockLeaderboardDataRepository.searchPlayer(any, any)).thenAnswer((_) async => [examplePlayer]);

          return _leaderboardDataCubit;
        },
        act: (cubit) => cubit.searchPlayer(leaderboardId, "t0nb"),
        expect: () => [
          const LeaderboardDataLoading(leaderboardData: [], searchedPlayers: []),
          LeaderboardDataLoaded(leaderboardData: const [], searchedPlayers: [examplePlayer])
        ],
      );
      blocTest<LeaderboardDataCubit, LeaderboardDataState>(
        'emits LeaderboardDataLoading and LeaderboardDataLoaded with empty array when no players found',
        build: () {
          when(_mockLeaderboardDataRepository.searchPlayer(any, any)).thenAnswer((_) async => []);

          return _leaderboardDataCubit;
        },
        act: (cubit) => cubit.searchPlayer(leaderboardId, "abc"),
        expect: () => [
          const LeaderboardDataLoading(leaderboardData: [], searchedPlayers: []),
          const LeaderboardDataLoaded(leaderboardData: [], searchedPlayers: []),
        ],
      );
      blocTest<LeaderboardDataCubit, LeaderboardDataState>(
        'emits LeaderboardDataLoading and LeaderboardDataError when searching player failed',
        build: () {
          when(_mockLeaderboardDataRepository.searchPlayer(any, any)).thenThrow(Error);

          return _leaderboardDataCubit;
        },
        act: (cubit) => cubit.searchPlayer(leaderboardId, "T0nb"),
        expect: () => [isA<LeaderboardDataLoading>(), isA<LeaderboardDataError>()],
      );
    });
  });
}
