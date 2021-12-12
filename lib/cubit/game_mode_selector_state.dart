part of 'game_mode_selector_cubit.dart';

class GameModeSelectorState extends Equatable {
  final int leaderboardGameModeIndex;
  final int ratingHistoryGameModeIndex;

  const GameModeSelectorState({required this.leaderboardGameModeIndex, required this.ratingHistoryGameModeIndex});

  @override
  List<Object> get props => [leaderboardGameModeIndex, ratingHistoryGameModeIndex];
}
