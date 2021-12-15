part of 'match_history_data_cubit.dart';

abstract class MatchHistoryDataState extends Equatable {
  final List<Match> matches;
  const MatchHistoryDataState({required this.matches});

  @override
  List<Object> get props => [];
}

class MatchHistoryDataInitial extends MatchHistoryDataState {
  const MatchHistoryDataInitial({matches}) : super(matches: matches);
}

class MatchHistoryDataLoading extends MatchHistoryDataState {
  const MatchHistoryDataLoading({matches}) : super(matches: matches);
}

class MatchHistoryDataLoaded extends MatchHistoryDataState {
  const MatchHistoryDataLoaded({matches}) : super(matches: matches);
}

class MatchHistoryDataError extends MatchHistoryDataState {
  const MatchHistoryDataError({matches}) : super(matches: matches);
}
