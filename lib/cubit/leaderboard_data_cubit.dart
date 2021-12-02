import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leaderboard_data_state.dart';

class LeaderboardDataCubit extends Cubit<LeaderboardDataState> {
  final LeaderboardDataRepository _leaderboardDataRepository = LeaderboardDataRepository();
  LeaderboardDataCubit() : super(const LeaderboardDataInitial(leaderboardData: [], filteredPlayers: []));

  Future<void> fetchLeaderboardData(int leaderboardId) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, filteredPlayers: state.filteredPlayers));
      final List<Player> leaderboardData = await _leaderboardDataRepository.fetchLeaderboardData(leaderboardId);
      emit(LeaderboardDataLoaded(leaderboardData: leaderboardData, filteredPlayers: state.filteredPlayers));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }

  void searchPlayer(String playerName) {
    final Iterable<dynamic> foundPlayers = state.leaderboardData.where((dynamic player) => player.name.toLowerCase().contains(playerName));
    emit(LeaderboardDataLoaded(leaderboardData: state.leaderboardData, filteredPlayers: foundPlayers.toList()));
  }
}
