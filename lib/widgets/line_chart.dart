import 'dart:math';

import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/models/rating.dart';
import 'package:aoeiv_leaderboard/models/time_series_rating.dart';
import 'package:aoeiv_leaderboard/utils/create_series_data.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:charts_flutter/src/text_element.dart' as text;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as style;

class RatingLineChart extends StatefulWidget {
  final List<Rating> ratingHistoryData;

  const RatingLineChart({required this.ratingHistoryData, Key? key}) : super(key: key);

  @override
  _RatingLineChartState createState() => _RatingLineChartState();
}

class _RatingLineChartState extends State<RatingLineChart> {
  static List selectedDatum = [];

  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart(
      createSeriesDataRating(widget.ratingHistoryData),
      animate: false,
      behaviors: [
        SelectNearest(eventTrigger: SelectionTrigger.tapAndDrag),
        LinePointHighlighter(symbolRenderer: CustomCircleSymbolRenderer(size: MediaQuery.of(context).size)),
      ],
      selectionModels: [
        SelectionModelConfig(
          type: SelectionModelType.info,
          changedListener: (SelectionModel model) {
            if (model.hasDatumSelection) {
              selectedDatum = [];
              for (SeriesDatum datumPair in model.selectedDatum) {
                final TimeSeriesRating dataPair = datumPair.datum;
                selectedDatum
                    .add({'color': ColorUtil.fromDartColor(kcPrimaryColor), 'text': "${dataPair.time.year}-${dataPair.time.month}-${dataPair.time.day}: ${dataPair.rating}"});
              }
            }
          },
        )
      ],
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

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  final Size size;

  CustomCircleSymbolRenderer({required this.size});

  @override
  void paint(ChartCanvas canvas, Rectangle bounds, {List<int>? dashPattern, Color? fillColor, FillPatternType? fillPattern, Color? strokeColor, double? strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);

    List tooltips = _RatingLineChartState.selectedDatum;

    if (tooltips.isNotEmpty) {
      num tipTextLen = (tooltips[0]['text']).length;
      num rectWidth = bounds.width + tipTextLen * 7.5;
      num rectHeight = bounds.height + 20 + (tooltips.length - 1) * 18;
      num left = bounds.left > (size.width) / 2 ? (bounds.left > size.width / 4 ? bounds.left - rectWidth : bounds.left - rectWidth / 2) : bounds.left - 40;

      canvas.drawRRect(
        Rectangle(left, 0, rectWidth, rectHeight),
        fill: Color.fromHex(code: '#666666'),
        radius: kbBorderRadius,
        roundBottomLeft: true,
        roundBottomRight: true,
        roundTopLeft: true,
        roundTopRight: true,
      );

      for (int i = 0; i < tooltips.length; i++) {
        canvas.drawPoint(
          point: Point(left.round() + 8, (i + 1) * 15),
          radius: 3,
          fill: tooltips[i]['color'],
          strokeWidthPx: 1,
        );
        style.TextStyle textStyle = style.TextStyle();
        textStyle.color = ColorUtil.fromDartColor(kcColorWhite);
        textStyle.fontSize = 13;
        canvas.drawText(text.TextElement(tooltips[i]['text'], style: textStyle), left.round() + 15, i * 15 + 8);
      }
    }
  }
}
