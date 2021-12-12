part of 'game_mode_selector_cubit.dart';

class GameModeSelectorState extends Equatable {
  final int leaderboardGameMode;
  final int ratingHistoryGameMode;

  const GameModeSelectorState({required this.leaderboardGameMode, required this.ratingHistoryGameMode});

  @override
  List<Object> get props => [leaderboardGameMode, ratingHistoryGameMode];
}
