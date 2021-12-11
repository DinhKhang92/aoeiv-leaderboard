import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leaderboard_data_state.dart';

class LeaderboardDataCubit extends Cubit<LeaderboardDataState> {
  final LeaderboardDataRepository _leaderboardDataRepository = LeaderboardDataRepository();
  LeaderboardDataCubit() : super(const LeaderboardDataInitial(leaderboardData: [], searchedPlayers: []));

  Future<void> fetchLeaderboardData(int leaderboardId) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> leaderboardData = await _leaderboardDataRepository.fetchLeaderboardData(leaderboardId);
      emit(LeaderboardDataLoaded(leaderboardData: leaderboardData, searchedPlayers: state.searchedPlayers));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }

  void searchPlayer(int leaderboardId, String playerName) async {
    final List<Player> searchedPlayers = await _leaderboardDataRepository.searchPlayer(leaderboardId, playerName);
    emit(LeaderboardDataLoaded(leaderboardData: state.leaderboardData, searchedPlayers: searchedPlayers));
  }
}
