import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_mode_selector_state.dart';

class GameModeSelectorCubit extends Cubit<GameModeSelectorState> {
  GameModeSelectorCubit() : super(const GameModeSelectorState(leaderboardGameMode: 0, ratingHistoryGameMode: 0));

  void setLeaderboardGameMode(int index) => emit(GameModeSelectorState(leaderboardGameMode: index, ratingHistoryGameMode: state.ratingHistoryGameMode));

  void setRatingHistoryGameMode(int index) => emit(GameModeSelectorState(leaderboardGameMode: state.leaderboardGameMode, ratingHistoryGameMode: index));

  void clearRatingHistoryGameMode() => emit(GameModeSelectorState(leaderboardGameMode: state.leaderboardGameMode, ratingHistoryGameMode: 0));
}
