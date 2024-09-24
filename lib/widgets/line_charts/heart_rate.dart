import 'dart:async';
import 'dart:math' as math;

// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:pet_body_health/constants/app_colors.dart';

class HeartRate extends StatefulWidget {
  const HeartRate({super.key});

  final Color sinColor = AppColors.contentColorBlue;

  @override
  State<HeartRate> createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  final limitCount = 50;
  final sinPoints = <FlSpot>[];

  double xValue = 0;
  double step = 5;

  var minTemp = 30.0;
  var maxTemp = 40.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    var random = math.Random();

    timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      var randomValue = minTemp + random.nextDouble() * (maxTemp - minTemp);
      while (sinPoints.length > limitCount) {
        sinPoints.removeAt(0);
      }
      // log("length: ${sinPoints.length}");
      setState(() {
        sinPoints.add(FlSpot(xValue, randomValue));
      });
      // log("after length: ${sinPoints.length}");
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return sinPoints.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text(
                'x: ${xValue.toStringAsFixed(1)}',
                style: const TextStyle(
                  color: AppColors.mainTextColor2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'heart beat: ${sinPoints.last.y.toStringAsFixed(1)}',
                style: TextStyle(
                  color: widget.sinColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: LineChart(
                    LineChartData(
                      minY: 10,
                      maxY: maxTemp + 5,
                      minX: sinPoints.first.x,
                      maxX: sinPoints.last.x,
                      lineTouchData: const LineTouchData(enabled: false),
                      clipData: const FlClipData.all(),
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: true,
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        tempLine(sinPoints),
                      ],
                      titlesData: const FlTitlesData(
                        show: false,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  LineChartBarData tempLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [widget.sinColor.withOpacity(1), widget.sinColor],
        stops: const [0.1, 1.0],
      ),
      barWidth: 2,
      isCurved: false,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
