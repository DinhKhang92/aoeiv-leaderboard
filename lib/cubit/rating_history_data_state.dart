part of 'rating_history_data_cubit.dart';

@immutable
abstract class RatingHistoryDataState extends Equatable {
  final List<Rating> ratingHistoryData;
  final Player? player;
  final Exception? error;

  const RatingHistoryDataState({required this.ratingHistoryData, this.player, this.error});

  @override
  List<Object> get props => [ratingHistoryData];
}

class RatingHistoryDataInitial extends RatingHistoryDataState {
  const RatingHistoryDataInitial({required List<Rating> ratingHistoryData, Player? player}) : super(ratingHistoryData: ratingHistoryData, player: player);
}

class RatingHistoryDataLoading extends RatingHistoryDataState {
  const RatingHistoryDataLoading({required List<Rating> ratingHistoryData, Player? player}) : super(ratingHistoryData: ratingHistoryData, player: player);
}

class RatingHistoryDataLoaded extends RatingHistoryDataState {
  const RatingHistoryDataLoaded({required List<Rating> ratingHistoryData, Player? player}) : super(ratingHistoryData: ratingHistoryData, player: player);
}

class RatingHistoryDataError extends RatingHistoryDataState {
  RatingHistoryDataError({Exception? error}) : super(ratingHistoryData: [], error: error);
}
