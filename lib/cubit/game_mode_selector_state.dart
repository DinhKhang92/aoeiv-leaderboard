part of 'game_mode_selector_cubit.dart';

class GameModeSelectorState extends Equatable {
  final int leaderboardGameModeIndex;
  final int ratingHistoryGameModeIndex;
  final int playerDetailModeIndex;

  const GameModeSelectorState({required this.leaderboardGameModeIndex, required this.ratingHistoryGameModeIndex, required this.playerDetailModeIndex});

  @override
  List<Object> get props => [leaderboardGameModeIndex, ratingHistoryGameModeIndex, playerDetailModeIndex];
}
