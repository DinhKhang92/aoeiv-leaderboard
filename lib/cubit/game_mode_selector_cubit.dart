import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_mode_selector_state.dart';

class GameModeSelectorCubit extends Cubit<GameModeSelectorState> {
  GameModeSelectorCubit() : super(const GameModeSelectorState(leaderboardGameModeIndex: 0, ratingHistoryGameModeIndex: 0, playerDetailModeIndex: 0));

  void setLeaderboardGameMode(int index) => emit(GameModeSelectorState(
        leaderboardGameModeIndex: index,
        ratingHistoryGameModeIndex: state.ratingHistoryGameModeIndex,
        playerDetailModeIndex: state.playerDetailModeIndex,
      ));

  void setRatingHistoryGameMode(int index) => emit(GameModeSelectorState(
        leaderboardGameModeIndex: state.leaderboardGameModeIndex,
        ratingHistoryGameModeIndex: index,
        playerDetailModeIndex: state.playerDetailModeIndex,
      ));

  void setPlayerDetailGameMode(int index) => emit(GameModeSelectorState(
        leaderboardGameModeIndex: state.leaderboardGameModeIndex,
        ratingHistoryGameModeIndex: state.ratingHistoryGameModeIndex,
        playerDetailModeIndex: index,
      ));

  void clearPlayerDetailNavigation() => emit(GameModeSelectorState(
        leaderboardGameModeIndex: state.leaderboardGameModeIndex,
        ratingHistoryGameModeIndex: 0,
        playerDetailModeIndex: 0,
      ));
}
