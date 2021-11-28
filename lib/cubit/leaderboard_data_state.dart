part of 'leaderboard_data_cubit.dart';

@immutable
abstract class LeaderboardDataState {
  final List leaderboardData;

  const LeaderboardDataState({required this.leaderboardData});
}

class LeaderboardDataInitial extends LeaderboardDataState {
  const LeaderboardDataInitial({leaderboardData}) : super(leaderboardData: leaderboardData);
}

class LeaderboardDataLoading extends LeaderboardDataState {
  const LeaderboardDataLoading({leaderboardData}) : super(leaderboardData: leaderboardData);
}

class LeaderboardDataLoaded extends LeaderboardDataState {
  const LeaderboardDataLoaded({leaderboardData}) : super(leaderboardData: leaderboardData);
}

class LeaderboardDataError extends LeaderboardDataState {
  LeaderboardDataError() : super(leaderboardData: []);
}
