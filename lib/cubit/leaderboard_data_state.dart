part of 'leaderboard_data_cubit.dart';

@immutable
abstract class LeaderboardDataState extends Equatable {
  final List leaderboardData;
  final List searchedPlayers;

  const LeaderboardDataState({required this.leaderboardData, required this.searchedPlayers});

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
  LeaderboardDataError() : super(leaderboardData: [], searchedPlayers: []);
}
