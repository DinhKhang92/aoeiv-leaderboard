import 'package:aoeiv_leaderboard/repositories/rating_history_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rating_history_data_state.dart';

class RatingHistoryDataCubit extends Cubit<RatingHistoryDataState> {
  final RatingHistoryDataRepository _ratingHistoryDataRepository = RatingHistoryDataRepository();

  RatingHistoryDataCubit() : super(const RatingHistoryDataInitial(ratingHistoryData: []));

  Future<void> fetchRatingHistoryData(int leaderboardId, int profileId) async {
    try {
      emit(RatingHistoryDataLoading(ratingHistoryData: state.ratingHistoryData));
      final List<int> ratingHistoryData = await _ratingHistoryDataRepository.fetchRatingHistoryData(leaderboardId, profileId);
      emit(RatingHistoryDataLoaded(ratingHistoryData: ratingHistoryData));
    } catch (e) {
      emit(RatingHistoryDataError());
    }
  }
}
