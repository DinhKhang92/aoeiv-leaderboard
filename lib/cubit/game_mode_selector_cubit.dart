import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_mode_selector_state.dart';

class GameModeSelectorCubit extends Cubit<GameModeSelectorState> {
  GameModeSelectorCubit() : super(const GameModeSelectorState(leaderboardGameModeIndex: 0, ratingHistoryGameModeIndex: 0));

  void setLeaderboardGameMode(int index) => emit(GameModeSelectorState(leaderboardGameModeIndex: index, ratingHistoryGameModeIndex: state.ratingHistoryGameModeIndex));

  void setRatingHistoryGameMode(int index) => emit(GameModeSelectorState(leaderboardGameModeIndex: state.leaderboardGameModeIndex, ratingHistoryGameModeIndex: index));

  void clearRatingHistoryGameMode() => emit(GameModeSelectorState(leaderboardGameModeIndex: state.leaderboardGameModeIndex, ratingHistoryGameModeIndex: 0));
}
