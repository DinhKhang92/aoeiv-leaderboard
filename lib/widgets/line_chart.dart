import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/utils/create_series_data.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class RatingLineChart extends StatefulWidget {
  final List<Rating> ratingHistoryData;

  const RatingLineChart({required this.ratingHistoryData, Key? key}) : super(key: key);

  @override
  _RatingLineChartState createState() => _RatingLineChartState();
}

class _RatingLineChartState extends State<RatingLineChart> {
  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      createSeriesDataRating(widget.ratingHistoryData),
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
