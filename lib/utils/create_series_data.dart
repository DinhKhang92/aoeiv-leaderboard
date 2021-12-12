import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/models/time_series_rating.dart';
import 'package:charts_flutter/flutter.dart';

List<Series<TimeSeriesRating, DateTime>> createSeriesDataRating(List<Rating> ratingHistoryData) {
  final List<TimeSeriesRating> dataList =
      ratingHistoryData.map((Rating ratingData) => TimeSeriesRating(time: DateTime.fromMillisecondsSinceEpoch(ratingData.timestamp * 1000), rating: ratingData.rating)).toList();

  final series = Series<TimeSeriesRating, DateTime>(
    id: 'Rating',
    colorFn: (_, __) => ColorUtil.fromDartColor(kcPrimaryColor),
    domainFn: (TimeSeriesRating rating, _) => rating.time,
    measureFn: (TimeSeriesRating rating, _) => rating.rating,
    data: dataList,
  );

  return [series];
}
