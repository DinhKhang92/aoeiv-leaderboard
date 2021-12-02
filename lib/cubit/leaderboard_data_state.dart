part of 'leaderboard_data_cubit.dart';

@immutable
abstract class LeaderboardDataState {
  final List leaderboardData;
  final List filteredPlayers;

  const LeaderboardDataState({required this.leaderboardData, required this.filteredPlayers});
}

class LeaderboardDataInitial extends LeaderboardDataState {
  const LeaderboardDataInitial({leaderboardData, filteredPlayers}) : super(leaderboardData: leaderboardData, filteredPlayers: filteredPlayers);
}

class LeaderboardDataLoading extends LeaderboardDataState {
  const LeaderboardDataLoading({leaderboardData, filteredPlayers}) : super(leaderboardData: leaderboardData, filteredPlayers: filteredPlayers);
}

class LeaderboardDataLoaded extends LeaderboardDataState {
  const LeaderboardDataLoaded({leaderboardData, filteredPlayers}) : super(leaderboardData: leaderboardData, filteredPlayers: filteredPlayers);
}

class LeaderboardDataError extends LeaderboardDataState {
  LeaderboardDataError() : super(leaderboardData: [], filteredPlayers: []);
}
