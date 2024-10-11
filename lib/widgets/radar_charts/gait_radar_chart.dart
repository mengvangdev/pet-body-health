import 'package:pet_body_health/constants/app_colors.dart';
import 'package:pet_body_health/resources/resources.dart';

class RadarChartSample1 extends StatefulWidget {
  const RadarChartSample1({super.key});

  final gridColor = AppColors.contentColorPurple;
  final titleColor = AppColors.contentColorPurple;
  final fashionColor = AppColors.contentColorRed;
  final artColor = AppColors.contentColorCyan;
  final boxingColor = AppColors.contentColorGreen;
  final entertainmentColor = AppColors.contentColorWhite;
  final offRoadColor = AppColors.contentColorYellow;

  @override
  State<RadarChartSample1> createState() => _RadarChartSample1State();
}

class _RadarChartSample1State extends State<RadarChartSample1> {
  double angleValue = 0;
  bool relativeAngleMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, child) {
        final gaitAxis = petProvider.gaitAxis;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   children: [
              //     const Text(
              //       'Angle',
              //       style: TextStyle(
              //         color: AppColors.contentColorRed,
              //       ),
              //     ),
              //     Slider(
              //       value: angleValue,
              //       max: 360,
              //       onChanged: (double value) =>
              //           setState(() => angleValue = value),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 4),
              AspectRatio(
                aspectRatio: 1.3,
                child: RadarChart(
                  RadarChartData(
                    dataSets: showingDataSets(gaitAxis),
                    radarBackgroundColor: Colors.transparent,
                    // borderData: FlBorderData(show: true),
                    radarBorderData:
                        const BorderSide(color: Colors.transparent),
                    // titlePositionPercentageOffset: 0.2,
                    titleTextStyle: TextStyle(
                      color: widget.titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    getTitle: (index, angle) {
                      final usedAngle =
                          relativeAngleMode ? angle + angleValue : angleValue;
                      switch (index) {
                        case 0:
                          return RadarChartTitle(
                            text: 'Gx',
                            angle: usedAngle,
                          );
                        case 1:
                          return RadarChartTitle(
                            text: 'Gy',
                            angle: usedAngle,
                          );
                        case 2:
                          return RadarChartTitle(
                            text: 'Gz',
                            angle: usedAngle,
                          );
                        default:
                          return const RadarChartTitle(text: '');
                      }
                    },
                    tickCount: 1,
                    ticksTextStyle: const TextStyle(
                        color: Colors.transparent, fontSize: 10),
                    tickBorderData: const BorderSide(color: Colors.transparent),
                    gridBorderData:
                        BorderSide(color: widget.gridColor, width: 2),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<RadarDataSet> showingDataSets(List<double> gaitAxis) {
    return rawDataSets(gaitAxis).asMap().entries.map((entry) {
      final rawDataSet = entry.value;
      return RadarDataSet(
        fillColor: rawDataSet.color.withOpacity(0.2),
        borderColor: rawDataSet.color,
        entryRadius: 3,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: 2.3,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets(List<double> gaitAxis) {
    return [
      RawDataSet(
        title: 'Gait Axis',
        color: widget.fashionColor,
        values: gaitAxis,
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
