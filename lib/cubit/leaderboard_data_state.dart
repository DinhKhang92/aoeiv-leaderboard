part of 'leaderboard_data_cubit.dart';

@immutable
abstract class LeaderboardDataState extends Equatable {
  final List leaderboardData;
  final List searchedPlayers;
  final Exception? error;

  const LeaderboardDataState({required this.leaderboardData, required this.searchedPlayers, this.error});

  @override
  List<Object> get props => [leaderboardData, searchedPlayers];
}

class LeaderboardDataInitial extends LeaderboardDataState {
  const LeaderboardDataInitial({leaderboardData, searchedPlayers}) : super(leaderboardData: leaderboardData, searchedPlayers: searchedPlayers);
}

class LeaderboardDataLoading extends LeaderboardDataState {
  const LeaderboardDataLoading({leaderboardData, searchedPlayers}) : super(leaderboardData: leaderboardData, searchedPlayers: searchedPlayers);
}

class LeaderboardDataLoaded extends LeaderboardDataState {
  const LeaderboardDataLoaded({leaderboardData, searchedPlayers}) : super(leaderboardData: leaderboardData, searchedPlayers: searchedPlayers);
}

class LeaderboardDataError extends LeaderboardDataState {
  LeaderboardDataError({Exception? error}) : super(leaderboardData: [], searchedPlayers: [], error: error);
}
