import 'package:aoeiv_leaderboard/config/config.dart';
import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/models/series_civilization.dart';
import 'package:aoeiv_leaderboard/utils/map_id_to_civilization_color.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  final Map civDistribution;
  final int totalCount;
  const SimplePieChart({required this.civDistribution, required this.totalCount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart<int>(
      _createSampleData(context),
      animate: false,
      layoutConfig: LayoutConfig(
        bottomMarginSpec: MarginSpec.fixedPixel(0),
        leftMarginSpec: MarginSpec.fixedPixel(0),
        rightMarginSpec: MarginSpec.fixedPixel(0),
        topMarginSpec: MarginSpec.fixedPixel(0),
      ),
      defaultRenderer: ArcRendererConfig(
        arcRatio: 0.4,
        arcRendererDecorators: [
          ArcLabelDecorator(
            labelPosition: ArcLabelPosition.inside,
          ),
        ],
      ),
    );
  }

  List<Series<SeriesCivilization, int>> _createSampleData(BuildContext context) {
    final List<SeriesCivilization> data = civDistribution.entries
        .map((entry) => SeriesCivilization(
              id: int.parse(entry.key),
              count: entry.value,
              percentage: (entry.value / totalCount * 100).round(),
              color: mapIdToCivilizationColor(int.parse(entry.key)),
            ))
        .toList();

    data.sort((a, b) => b.count.compareTo(a.count));

    return [
      Series<SeriesCivilization, int>(
        id: 'SeriesCivilization',
        domainFn: (SeriesCivilization seriesCivilization, _) => seriesCivilization.id,
        measureFn: (SeriesCivilization seriesCivilization, _) => seriesCivilization.count,
        colorFn: (SeriesCivilization seriesCivilization, _) => ColorUtil.fromDartColor(seriesCivilization.color),
        data: data,
        labelAccessorFn: (SeriesCivilization seriesCivilization, _) => "${seriesCivilization.percentage}%",
        insideLabelStyleAccessorFn: (SeriesCivilization seriesCivilization, _) => TextStyleSpec(
          fontSize: 12,
          color: seriesCivilization.id == CivilizationId.english.id || seriesCivilization.id == CivilizationId.holyRomanEmpire.id
              ? ColorUtil.fromDartColor(kcColorBlack)
              : ColorUtil.fromDartColor(kcColorWhite),
        ),
      )
    ];
  }
}
