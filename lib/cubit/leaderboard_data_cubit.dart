import 'package:aoeiv_leaderboard/models/player.dart';
import 'package:aoeiv_leaderboard/repositories/leaderboard_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'leaderboard_data_state.dart';

class LeaderboardDataCubit extends Cubit<LeaderboardDataState> {
  final LeaderboardDataRepository _leaderboardDataRepository = LeaderboardDataRepository();
  LeaderboardDataCubit() : super(const LeaderboardDataInitial(leaderboardData: []));

  Future<void> fetchLeaderboardData(int leaderboardId) async {
    try {
      emit(LeaderboardDataLoading(leaderboardData: state.leaderboardData));
      final List<Player> leaderboardData = await _leaderboardDataRepository.fetchLeaderboardData(leaderboardId);
      emit(LeaderboardDataLoaded(leaderboardData: leaderboardData));
    } catch (e) {
      emit(LeaderboardDataError());
    }
  }
}
