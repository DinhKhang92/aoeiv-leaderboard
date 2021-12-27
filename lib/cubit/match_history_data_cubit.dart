import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_history_data_state.dart';

class MatchHistoryDataCubit extends Cubit<MatchHistoryDataState> {
  final MatchHistoryDataRepository matchHistoryDataRepository;
  MatchHistoryDataCubit({required this.matchHistoryDataRepository}) : super(const MatchHistoryDataInitial(matches: [], civilizationDistribution: {}, totalCount: 1));

  Future<void> fetchMatchHistoryData(int leaderboardId, int profileId) async {
    try {
      emit(MatchHistoryDataLoading(matches: state.filteredMatches, civilizationDistribution: state.civilizationDistribution, totalCount: state.totalCount));
      final List<Match> matches = await matchHistoryDataRepository.fetchMatchHistoryData(profileId);
      final List<Match> filteredMatches = matchHistoryDataRepository.filterMatches(leaderboardId, matches);
      final Map<String, int> civilizationDistribution = matchHistoryDataRepository.getCivDistributionByProfileId(filteredMatches, profileId);
      emit(MatchHistoryDataLoaded(matches: filteredMatches, civilizationDistribution: civilizationDistribution, totalCount: filteredMatches.length));
    } catch (e) {
      emit(MatchHistoryDataError());
    }
  }
}
