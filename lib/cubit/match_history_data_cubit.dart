import 'package:aoeiv_leaderboard/models/match.dart';
import 'package:aoeiv_leaderboard/repositories/match_history_data_repository.dart';
import 'package:aoeiv_leaderboard/utils/map_leaderboard_id_to_num_players.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_history_data_state.dart';

class MatchHistoryDataCubit extends Cubit<MatchHistoryDataState> {
  final MatchHistoryDataRepository matchHistoryDataRepository;
  MatchHistoryDataCubit({required this.matchHistoryDataRepository}) : super(const MatchHistoryDataInitial(matches: []));

  Future<void> fetchMatchHistoryData(int leaderboardId, int profileId) async {
    emit(MatchHistoryDataLoading(matches: state.filteredMatches));
    final List<Match> matches = await matchHistoryDataRepository.fetchMatchHistoryData(profileId);
    final List<Match> filteredMatches = matches.where((Match match) => match.numPlayers == mapLeaderboardIdToNumPlayers(leaderboardId)).toList();
    emit(MatchHistoryDataLoaded(matches: filteredMatches));
  }
}
