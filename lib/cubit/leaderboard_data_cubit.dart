import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'leaderboard_data_state.dart';

class LeaderboardDataCubit extends Cubit<LeaderboardDataState> {
  final LeaderboardDataRepository leaderboardDataRepository;
  final Client _client = Client();
  LeaderboardDataCubit({required this.leaderboardDataRepository}) : super(const LeaderboardDataInitial(leaderboardData: [], searchedPlayers: []));

  Future<void> fetchLeaderboardData(int leaderboardId) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> leaderboardData = await leaderboardDataRepository.fetchLeaderboardData(_client, leaderboardId);
      emit(LeaderboardDataLoaded(leaderboardData: leaderboardData, searchedPlayers: state.searchedPlayers));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }

  Future<void> searchPlayer(int leaderboardId, String playerName) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData, searchedPlayers: state.searchedPlayers));
      final List<Player> searchedPlayers = await leaderboardDataRepository.searchPlayer(_client, leaderboardId, playerName);
      emit(LeaderboardDataLoaded(leaderboardData: state.leaderboardData, searchedPlayers: searchedPlayers));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }
}
