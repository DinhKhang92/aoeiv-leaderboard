import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'leaderboard_data_state.dart';

class LeaderboardDataCubit extends Cubit<LeaderboardDataState> {
  final LeaderboardDataRepository leaderboardDataRepository;
  LeaderboardDataCubit({required this.leaderboardDataRepository}) : super(const LeaderboardDataInitial(leaderboardData: [], searchedPlayers: []));

  Future<void> fetchLeaderboardData(String leaderboard) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> leaderboardData = await leaderboardDataRepository.fetchLeaderboardData(leaderboard);
      emit(LeaderboardDataLoaded(leaderboardData: leaderboardData, searchedPlayers: state.searchedPlayers));
    } on Exception catch (error, _) {
      emit(LeaderboardDataError(error: error));
    }
  }

  Future<void> searchPlayer(String leaderboard, String playerName) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> searchedPlayers = await leaderboardDataRepository.searchPlayer(leaderboard, playerName);
      emit(LeaderboardDataLoaded(leaderboardData: state.leaderboardData, searchedPlayers: searchedPlayers));
    } on Exception catch (error, _) {
      emit(LeaderboardDataError(error: error));
    }
  }
}
