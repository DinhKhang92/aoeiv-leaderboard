import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leaderboard_data_state.dart';

class LeaderboardDataCubit extends Cubit<LeaderboardDataState> {
  final LeaderboardDataRepository leaderboardDataRepository;
  LeaderboardDataCubit(this.leaderboardDataRepository) : super(const LeaderboardDataInitial(leaderboardData: [], searchedPlayers: []));

  Future<void> fetchLeaderboardData(int leaderboardId) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> leaderboardData = await leaderboardDataRepository.fetchLeaderboardData(leaderboardId);
      emit(LeaderboardDataLoaded(leaderboardData: leaderboardData, searchedPlayers: state.searchedPlayers));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }

  Future<void> searchPlayer(int leaderboardId, String playerName) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> searchedPlayers = await leaderboardDataRepository.searchPlayer(leaderboardId, playerName);
      emit(LeaderboardDataLoaded(leaderboardData: state.leaderboardData, searchedPlayers: searchedPlayers));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }
}
