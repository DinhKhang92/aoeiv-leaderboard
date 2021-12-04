import 'package:bloc/bloc.dart';

part 'rating_history_mode_selector_state.dart';

class RatingHistoryModeSelectorCubit extends Cubit<RatingHistoryModeSelectorState> {
  RatingHistoryModeSelectorCubit() : super(RatingHistoryModeSelectorState(index: 0));

  void setIndex(int index) => emit(RatingHistoryModeSelectorState(index: index));
}
