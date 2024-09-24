import 'dart:async';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pet_body_health/constants/app_colors.dart';
import 'package:pet_body_health/providers/ble_provider.dart';
import 'package:pet_body_health/providers/pet_provider.dart';
import 'package:provider/provider.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  final Color sinColor = AppColors.contentColorBlue;

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  // final limitCount = 40;
  // final sinPoints = <FlSpot>[];

  // double xValue = 0;
  // double step = 0.05;

  // late Timer timer;

  // @override
  // void initState() {
  //   super.initState();

  // }
  final limitCount = 40;
  final sinPoints = <FlSpot>[];

  double xValue = 0;
  double step = 1;

  late Timer timer;
  var minTemp = 10.0;
  var maxTemp = 40.0;

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
    //   while (sinPoints.length > limitCount) {
    //     sinPoints.removeAt(0);
    //   }
    //   setState(() {
    //     sinPoints.add(FlSpot(xValue, math.sin(xValue)));
    //   });
    //   xValue += step;
    // });
    var random = math.Random();
    timer = Timer.periodic(const Duration(milliseconds: 500), (t) {
      var randomValue = (minTemp * 2 + random.nextDouble()) * maxTemp;
      // log("random : $randomValue");
      while (sinPoints.length > limitCount) {
        sinPoints.removeAt(0);
      }
      //  log("length: ${sinPoints.length}");
      setState(() {
        sinPoints.add(FlSpot(xValue, randomValue));
      });
      // log("minX : ${sinPoints.first.x}");
      // log("maxX : ${sinPoints.last.x}");
      // log("after length: ${sinPoints.length}");
      xValue += step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PetProvider, BleProvider>(
      builder: (context, petProvider, bleProiver, child) {
        if (bleProiver.connected) {
          if (petProvider.petData.isNotEmpty) {
            //  final temperature = petProvider.petData.last.temperature;
            // log("pets : ${petProvider.petData.length}");
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  'x: $xValue',
                  style: const TextStyle(
                    color: AppColors.mainTextColor2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'sin: ${sinPoints.last.x}',
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
                        minY: minTemp,
                        maxY: maxTemp,
                        minX: 0,
                        maxX: 9,
                        lineTouchData: const LineTouchData(enabled: false),
                        clipData: const FlClipData.all(),
                        gridData: const FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          sinLine(sinPoints),
                        ],
                        titlesData: const FlTitlesData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        }
        return Container();
      },
    );
  }

  LineChartBarData sinLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [widget.sinColor.withOpacity(0), widget.sinColor],
        stops: const [0.1, 1.0],
      ),
      barWidth: 4,
      isCurved: true,
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
