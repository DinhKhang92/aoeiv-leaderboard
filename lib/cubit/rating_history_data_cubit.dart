import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/repositories/rating_history_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'rating_history_data_state.dart';

class RatingHistoryDataCubit extends Cubit<RatingHistoryDataState> {
  final RatingHistoryDataRepository ratingHistoryDataRepository;

  RatingHistoryDataCubit({required this.ratingHistoryDataRepository}) : super(const RatingHistoryDataInitial(ratingHistoryData: []));

  Future<void> fetchPlayerData(int profileId) async {
    try {
      emit(RatingHistoryDataLoading(ratingHistoryData: state.ratingHistoryData, player: state.player));
      // final List<Rating> ratingHistoryData = await ratingHistoryDataRepository.fetchRatingHistoryData(leaderboard, profileId);
      final Player player = await ratingHistoryDataRepository.fetchPlayerDataByProfileId(profileId);
      emit(RatingHistoryDataLoaded(ratingHistoryData: [], player: player));
    } on Exception catch (error, _) {
      emit(RatingHistoryDataError(error: error));
    }
  }
}
