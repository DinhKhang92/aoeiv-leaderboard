part of 'match_history_data_cubit.dart';

abstract class MatchHistoryDataState extends Equatable {
  final List<Match> filteredMatches;
  final Map civilizationDistribution;
  final int totalCount;

  const MatchHistoryDataState({
    required this.filteredMatches,
    required this.civilizationDistribution,
    required this.totalCount,
  });

  @override
  List<Object> get props => [];
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
  MatchHistoryDataError() : super(filteredMatches: [], civilizationDistribution: {}, totalCount: 1);
}
