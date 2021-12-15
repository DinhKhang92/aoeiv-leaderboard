import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_history_data_state.dart';

class MatchHistoryDataCubit extends Cubit<MatchHistoryDataState> {
  final MatchHistoryDataRepository matchHistoryDataRepository;
  MatchHistoryDataCubit({required this.matchHistoryDataRepository}) : super(const MatchHistoryDataInitial(matches: []));

  Future<void> fetchMatchHistoryData(int profileId) async {
    emit(MatchHistoryDataLoading(matches: state.matches));
    final List<Match> matches = await matchHistoryDataRepository.fetchMatchHistoryData(profileId);
    emit(MatchHistoryDataLoaded(matches: matches));
  }
}
