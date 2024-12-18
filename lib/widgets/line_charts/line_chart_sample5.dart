import 'dart:developer';

import 'package:pet_body_health/constants/app_colors.dart';
import 'package:pet_body_health/resources/resources.dart';

class LineChartSample5 extends StatefulWidget {
  const LineChartSample5({
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
  })  : gradientColor1 = gradientColor1 ?? AppColors.contentColorRed,
        gradientColor2 = gradientColor2 ?? AppColors.contentColorOrange,
        gradientColor3 = gradientColor3 ?? AppColors.contentColorGreen,
        indicatorStrokeColor = indicatorStrokeColor ?? AppColors.mainTextColor1;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  @override
  State<LineChartSample5> createState() => _LineChartSample5State();
}

class _LineChartSample5State extends State<LineChartSample5> {
  List<int> showingTooltipOnSpots = [1, 3, 5];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.contentColorPink,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00:00';
        break;
      case 1:
        text = '04:00';
        break;
      case 2:
        text = '08:00';
        break;
      case 3:
        text = '12:00';
        break;
      case 4:
        text = '16:00';
        break;
      case 5:
        text = '20:00';
        break;
      case 6:
        text = '23:59';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 80,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(
      double value, TitleMeta meta, double chartWidth, double activity) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Digital',
      fontSize: 15,
    );
    log("value = $value");
    // String text;
    // switch (value.toInt()) {
    //   case 2:
    //     text = 'Bad';
    //     break;
    //   case 5:
    //     text = 'Normal';
    //     break;
    //   case 8:
    //     text = 'Good';
    //     break;
    //   default:
    //     return Container();
    // }
    String text;
    var val = value.toInt();
    if (activity < 5) {
      switch (val) {
        case 1:
          text = '1';
          break;
        case 2:
          text = '2';
          break;
        case 3:
          text = '3';
          break;
        case 4:
          text = '4';
          break;
        default:
          text = '5';
          return Container();
      }
    } else if (activity >= 5 && activity < 10) {
      switch (val) {
        case 2:
          text = '2';
          break;
        case 4:
          text = '4';
          break;
        case 6:
          text = '6';
          break;
        case 8:
          text = '8';
          break;
        default:
          text = '10';
          return Container();
      }
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,

      // space: 200,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(builder: (_, petProvider, child) {
      final lineBarsData = [
        LineChartBarData(
          showingIndicators: showingTooltipOnSpots,
          spots: petProvider.activities,
          isCurved: true,
          barWidth: 5,
          shadow: const Shadow(
            blurRadius: 8,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                widget.gradientColor1.withOpacity(0.4),
                widget.gradientColor2.withOpacity(0.4),
                widget.gradientColor3.withOpacity(0.4),
              ],
            ),
          ),
          dotData: const FlDotData(show: false),
          gradient: LinearGradient(
            colors: [
              widget.gradientColor1,
              widget.gradientColor2,
              widget.gradientColor3,
            ],
            stops: const [0.1, 0.4, 0.9],
          ),
        ),
      ];

      final tooltipsOnBar = lineBarsData[0];
      return AspectRatio(
        aspectRatio: 2.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 10,
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return LineChart(
              LineChartData(
                showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                  return ShowingTooltipIndicators([
                    LineBarSpot(
                      tooltipsOnBar,
                      lineBarsData.indexOf(tooltipsOnBar),
                      tooltipsOnBar.spots[index],
                    ),
                  ]);
                }).toList(),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      final spotIndex = response.lineBarSpots!.first.spotIndex;
                      setState(() {
                        if (showingTooltipOnSpots.contains(spotIndex)) {
                          showingTooltipOnSpots.remove(spotIndex);
                        } else {
                          showingTooltipOnSpots.add(spotIndex);
                        }
                      });
                    }
                  },
                  mouseCursorResolver:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return SystemMouseCursors.basic;
                    }
                    return SystemMouseCursors.click;
                  },
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        const FlLine(
                          color: Colors.pink,
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 8,
                            color: lerpGradient(
                              barData.gradient!.colors,
                              barData.gradient!.stops!,
                              percent / 100,
                            ),
                            strokeWidth: 2,
                            strokeColor: widget.indicatorStrokeColor,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.pink,
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                      return lineBarsSpot.map((lineBarSpot) {
                        return LineTooltipItem(
                          lineBarSpot.y.toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: lineBarsData,
                minY: 0,
                maxY: 10,
                maxX: 5,
                minX: 0,
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return leftTitleWidgets(
                            value,
                            meta,
                            constraints.maxWidth,
                            petProvider.activities.last.y);
                      },
                      reservedSize: 60,
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: AppColors.borderColor,
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
