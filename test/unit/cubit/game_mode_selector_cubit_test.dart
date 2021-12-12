import 'package:aoeiv_leaderboard/cubit/game_mode_selector_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("GameModeSelectorCubit", () {
    GameModeSelectorCubit _gameModeSelectorCubit = GameModeSelectorCubit();

    setUp(() {
      _gameModeSelectorCubit = GameModeSelectorCubit();
    });

    test('emits index 0 for leaderboard and rating history gamemode after initializing', () {
      expect(_gameModeSelectorCubit.state.leaderboardGameMode, 0);
      expect(_gameModeSelectorCubit.state.ratingHistoryGameMode, 0);
    });

    blocTest<GameModeSelectorCubit, GameModeSelectorState>(
      'emits state with leaderboard game mode of 2 after setting it to 2',
      build: () => _gameModeSelectorCubit,
      act: (cubit) => cubit.setLeaderboardGameMode(2),
      expect: () => [const GameModeSelectorState(leaderboardGameMode: 2, ratingHistoryGameMode: 0)],
    );
    blocTest<GameModeSelectorCubit, GameModeSelectorState>(
      'emits state with rating history game mode of 2 after setting it to 2',
      build: () => _gameModeSelectorCubit,
      act: (cubit) => cubit.setRatingHistoryGameMode(2),
      expect: () => [const GameModeSelectorState(leaderboardGameMode: 0, ratingHistoryGameMode: 2)],
    );
    blocTest<GameModeSelectorCubit, GameModeSelectorState>(
      'emits state with rating history game mode of 0 after clearing it',
      build: () => _gameModeSelectorCubit,
      seed: () => const GameModeSelectorState(leaderboardGameMode: 0, ratingHistoryGameMode: 2),
      act: (cubit) => cubit.clearRatingHistoryGameMode(),
      expect: () => [const GameModeSelectorState(leaderboardGameMode: 0, ratingHistoryGameMode: 0)],
    );
  });
}
