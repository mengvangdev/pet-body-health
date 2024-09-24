import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pet_body_health/constants/app_colors.dart';

class GaitRadarChart extends StatefulWidget {
  const GaitRadarChart({super.key});

  final gridColor = AppColors.contentColorPurple;
  final titleColor = AppColors.contentColorPurple;
  final fashionColor = AppColors.contentColorRed;
  final artColor = AppColors.contentColorCyan;
  final boxingColor = AppColors.contentColorGreen;
  final entertainmentColor = AppColors.contentColorWhite;
  final offRoadColor = AppColors.contentColorYellow;

  @override
  State<GaitRadarChart> createState() => _GaitRadarChartState();
}

class _GaitRadarChartState extends State<GaitRadarChart> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Title configuration',
            style: TextStyle(
              color: AppColors.mainTextColor2,
            ),
          ),
          Row(
            children: [
              const Text(
                'Angle',
                style: TextStyle(
                  color: AppColors.mainTextColor2,
                ),
              ),
              Slider(
                value: angleValue,
                max: 360,
                onChanged: (double value) => setState(() => angleValue = value),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: relativeAngleMode,
                onChanged: (v) => setState(() => relativeAngleMode = v!),
              ),
              const Text('Relative'),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedDataSetIndex = -1;
              });
            },
            child: Text(
              'Categories'.toUpperCase(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
                color: AppColors.mainTextColor1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rawDataSets()
                .asMap()
                .map((index, value) {
                  // final isSelected = index == selectedDataSetIndex;
                  return MapEntry(
                    index,
                    GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   selectedDataSetIndex = index;
                        // });
                      },
                      // child: AnimatedContainer(
                      //   duration: const Duration(milliseconds: 300),
                      //   margin: const EdgeInsets.symmetric(vertical: 2),
                      //   height: 26,
                      //   decoration: BoxDecoration(
                      //     color: isSelected
                      //         ? AppColors.pageBackground
                      //         : Colors.transparent,
                      //     borderRadius: BorderRadius.circular(46),
                      //   ),
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 4,
                      //     horizontal: 6,
                      //   ),
                      // child: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     AnimatedContainer(
                      //       duration: const Duration(milliseconds: 400),
                      //       curve: Curves.easeInToLinear,
                      //       padding: EdgeInsets.all(isSelected ? 8 : 6),
                      //       decoration: BoxDecoration(
                      //         color: value.color,
                      //         shape: BoxShape.circle,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 8),
                      //     AnimatedDefaultTextStyle(
                      //       duration: const Duration(milliseconds: 300),
                      //       curve: Curves.easeInToLinear,
                      //       style: TextStyle(
                      //         color:
                      //             isSelected ? value.color : widget.gridColor,
                      //       ),
                      //       child: Text(value.title),
                      //     ),
                      //   ],
                      // ),
                      // ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
          AspectRatio(
            aspectRatio: 1.3,
            child: RadarChart(
              RadarChartData(
                radarTouchData: RadarTouchData(
                  touchCallback: (FlTouchEvent event, response) {
                    if (!event.isInterestedForInteractions) {
                      setState(() {
                        selectedDataSetIndex = -1;
                      });
                      return;
                    }
                    setState(() {
                      selectedDataSetIndex =
                          response?.touchedSpot?.touchedDataSetIndex ?? -1;
                    });
                  },
                ),
                dataSets: showingDataSets(),
                radarBackgroundColor: Colors.transparent,
                borderData: FlBorderData(show: true),
                radarBorderData: const BorderSide(color: Colors.transparent),
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: const TextStyle(fontSize: 14),
                getTitle: (index, angle) {
                  final usedAngle =
                      relativeAngleMode ? angle + angleValue : angleValue;
                  switch (index) {
                    case 0:
                      return RadarChartTitle(
                        text: 'x',
                        angle: usedAngle,
                      );
                    case 1:
                      return RadarChartTitle(
                        text: 'y',
                        angle: usedAngle,
                      );
                    case 2:
                      return RadarChartTitle(
                        text: 'z',
                        angle: usedAngle,
                      );
                    default:
                      return const RadarChartTitle(text: '');
                  }
                },
                tickCount: 1,
                ticksTextStyle:
                    const TextStyle(color: Colors.transparent, fontSize: 10),
                tickBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(color: widget.gridColor, width: 2),
              ),
              swapAnimationDuration: const Duration(milliseconds: 500),
            ),
          ),
        ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Boxing',
        color: widget.boxingColor,
        values: [
          100,
          250,
          100,
        ],
      ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}
