import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class TimeSeriesRating {
  final DateTime time;
  final int rating;

  TimeSeriesRating(this.time, this.rating);
}

class TestLineChart extends StatefulWidget {
  final List<Rating> ratingHistoryData;
  const TestLineChart({required this.ratingHistoryData, Key? key}) : super(key: key);

  @override
  _TestLineChartState createState() => _TestLineChartState();
}

class _TestLineChartState extends State<TestLineChart> {
  List<Series<TimeSeriesRating, DateTime>> _createSeriesData() {
    final List<TimeSeriesRating> dataList = widget.ratingHistoryData.map((data) {
      final Rating rating = data;
      return TimeSeriesRating(DateTime.fromMillisecondsSinceEpoch(rating.timestamp * 1000), rating.rating);
    }).toList();

    final series = Series<TimeSeriesRating, DateTime>(
      id: 'Rating',
      colorFn: (_, __) => ColorUtil.fromDartColor(kcPrimaryColor),
      domainFn: (TimeSeriesRating rating, _) => rating.time,
      measureFn: (TimeSeriesRating rating, _) => rating.rating,
      data: dataList,
    );
    return [series];
  }

  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      _createSeriesData(),
      animate: false,
      domainAxis: DateTimeAxisSpec(
        renderSpec: GridlineRendererSpec(
          labelStyle: const TextStyleSpec(
            color: MaterialPalette.white,
          ),
          lineStyle: LineStyleSpec(
            color: ColorUtil.fromDartColor(kcUnselectedColor),
          ),
        ),
      ),
      primaryMeasureAxis: NumericAxisSpec(
        tickProviderSpec: const BasicNumericTickProviderSpec(
          zeroBound: false,
          dataIsInWholeNumbers: true,
          desiredMinTickCount: 3,
        ),
        renderSpec: GridlineRendererSpec(
          labelStyle: const TextStyleSpec(
            color: MaterialPalette.white,
          ),
          lineStyle: LineStyleSpec(
            color: ColorUtil.fromDartColor(kcUnselectedColor),
          ),
          axisLineStyle: LineStyleSpec(
            thickness: 2,
            color: ColorUtil.fromDartColor(kcUnselectedColor),
          ),
        ),
      ),
    );
  }
}
