part of 'match_history_data_cubit.dart';

abstract class MatchHistoryDataState extends Equatable {
  final List<Match> filteredMatches;
  const MatchHistoryDataState({required this.filteredMatches});

  @override
  List<Object> get props => [];
}

class MatchHistoryDataInitial extends MatchHistoryDataState {
  const MatchHistoryDataInitial({required List<Match> matches}) : super(filteredMatches: matches);
}

class MatchHistoryDataLoading extends MatchHistoryDataState {
  const MatchHistoryDataLoading({required List<Match> matches}) : super(filteredMatches: matches);
}

class MatchHistoryDataLoaded extends MatchHistoryDataState {
  const MatchHistoryDataLoaded({required List<Match> matches}) : super(filteredMatches: matches);
}

class MatchHistoryDataError extends MatchHistoryDataState {
  MatchHistoryDataError() : super(filteredMatches: []);
}
