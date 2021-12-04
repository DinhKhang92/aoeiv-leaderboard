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
  final List ratingHistoryData;
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
      animate: true,
      domainAxis: const DateTimeAxisSpec(
        renderSpec: GridlineRendererSpec(
          labelStyle: TextStyleSpec(
            color: MaterialPalette.white,
          ),
          lineStyle: LineStyleSpec(
            color: Color(r: 182, g: 182, b: 182),
          ),
        ),
      ),
      primaryMeasureAxis: const NumericAxisSpec(
        renderSpec: GridlineRendererSpec(
          labelStyle: TextStyleSpec(
            color: MaterialPalette.white,
          ),
          lineStyle: LineStyleSpec(
            color: Color(r: 182, g: 182, b: 182),
          ),
          axisLineStyle: LineStyleSpec(
            color: Color(r: 182, g: 182, b: 182),
          ),
        ),
      ),
    );
  }
}
