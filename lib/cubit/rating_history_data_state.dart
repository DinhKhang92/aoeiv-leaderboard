part of 'rating_history_data_cubit.dart';

@immutable
abstract class RatingHistoryDataState {
  final List ratingHistoryData;

  const RatingHistoryDataState({required this.ratingHistoryData});
}

class RatingHistoryDataInitial extends RatingHistoryDataState {
  const RatingHistoryDataInitial({ratingHistoryData}) : super(ratingHistoryData: ratingHistoryData);
}

class RatingHistoryDataLoading extends RatingHistoryDataState {
  const RatingHistoryDataLoading({ratingHistoryData}) : super(ratingHistoryData: ratingHistoryData);
}

class RatingHistoryDataLoaded extends RatingHistoryDataState {
  const RatingHistoryDataLoaded({ratingHistoryData}) : super(ratingHistoryData: ratingHistoryData);
}

class RatingHistoryDataError extends RatingHistoryDataState {
  RatingHistoryDataError() : super(ratingHistoryData: []);
}
