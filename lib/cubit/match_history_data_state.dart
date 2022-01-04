part of 'match_history_data_cubit.dart';

abstract class MatchHistoryDataState extends Equatable {
  final List<Match> filteredMatches;
  final Map civilizationDistribution;
  final int totalCount;
  final Exception? error;

  const MatchHistoryDataState({
    required this.filteredMatches,
    required this.civilizationDistribution,
    required this.totalCount,
    this.error,
  });

  @override
  List<Object> get props => [filteredMatches, civilizationDistribution, totalCount];
}

class MatchHistoryDataInitial extends MatchHistoryDataState {
  const MatchHistoryDataInitial({required List<Match> matches, required Map civilizationDistribution, required int totalCount})
      : super(filteredMatches: matches, civilizationDistribution: civilizationDistribution, totalCount: totalCount);
}

class MatchHistoryDataLoading extends MatchHistoryDataState {
  const MatchHistoryDataLoading({required List<Match> matches, required Map civilizationDistribution, required int totalCount})
      : super(filteredMatches: matches, civilizationDistribution: civilizationDistribution, totalCount: totalCount);
}

class MatchHistoryDataLoaded extends MatchHistoryDataState {
  const MatchHistoryDataLoaded({required List<Match> matches, required Map civilizationDistribution, required int totalCount})
      : super(filteredMatches: matches, civilizationDistribution: civilizationDistribution, totalCount: totalCount);
}

class MatchHistoryDataError extends MatchHistoryDataState {
  MatchHistoryDataError({Exception? error}) : super(filteredMatches: [], civilizationDistribution: {}, totalCount: 1, error: error);
}
