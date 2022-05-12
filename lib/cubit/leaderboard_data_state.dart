part of 'leaderboard_data_cubit.dart';

@immutable
abstract class LeaderboardDataState extends Equatable {
  final List<PlayerPreview> leaderboardData;
  final List<PlayerPreview> searchedPlayers;
  final Exception? error;

  const LeaderboardDataState({required this.leaderboardData, required this.searchedPlayers, this.error});

  @override
  List<Object> get props => [leaderboardData, searchedPlayers];
}

class LeaderboardDataInitial extends LeaderboardDataState {
  const LeaderboardDataInitial({required List<PlayerPreview> leaderboardData, required List<PlayerPreview> searchedPlayers})
      : super(leaderboardData: leaderboardData, searchedPlayers: searchedPlayers);
}

class LeaderboardDataLoading extends LeaderboardDataState {
  const LeaderboardDataLoading({required List<PlayerPreview> leaderboardData, required List<PlayerPreview> searchedPlayers})
      : super(leaderboardData: leaderboardData, searchedPlayers: searchedPlayers);
}

class LeaderboardDataLoaded extends LeaderboardDataState {
  const LeaderboardDataLoaded({required List<PlayerPreview> leaderboardData, required List<PlayerPreview> searchedPlayers})
      : super(leaderboardData: leaderboardData, searchedPlayers: searchedPlayers);
}

class LeaderboardDataError extends LeaderboardDataState {
  LeaderboardDataError({required Exception error}) : super(leaderboardData: [], searchedPlayers: [], error: error);
}
