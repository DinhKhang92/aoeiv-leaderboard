import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class TimeSeriesSales {
  final DateTime time;
  final int rating;

  TimeSeriesSales(this.time, this.rating);
}

class TestLineChart extends StatefulWidget {
  final List<Rating> ratingHistoryData;
  const TestLineChart({required this.ratingHistoryData, Key? key}) : super(key: key);

  @override
  _TestLineChartState createState() => _TestLineChartState();
}

class _TestLineChartState extends State<TestLineChart> {
  List<Series<TimeSeriesSales, DateTime>> _createSeriesData() {
    final List<TimeSeriesSales> dataList = widget.ratingHistoryData.map((data) {
      final Rating rating = data;
      return TimeSeriesSales(DateTime.fromMillisecondsSinceEpoch(rating.timestamp * 1000), rating.rating);
    }).toList();

    final series = Series<TimeSeriesSales, DateTime>(
      id: 'Sales',
      colorFn: (_, __) => ColorUtil.fromDartColor(primaryColor),
      domainFn: (TimeSeriesSales sales, _) => sales.time,
      measureFn: (TimeSeriesSales sales, _) => sales.rating,
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
            color: ColorUtil.fromDartColor(unselectedColor),
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
            color: ColorUtil.fromDartColor(unselectedColor),
          ),
          axisLineStyle: LineStyleSpec(
            thickness: 2,
            color: ColorUtil.fromDartColor(unselectedColor),
          ),
        ),
      ),
    );
  }
}
