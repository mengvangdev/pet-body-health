import 'dart:async';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pet_body_health/constants/app_colors.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.contentColorBlue,
    AppColors.contentColorCyan,
    AppColors.contentColorOrange,
    AppColors.contentColorRed,
  ];

  List<int> activities = [];

  bool showAvg = false;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (time) {
      // Todo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        Container(
          color: Colors.pink,
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
                log("showAvg = $showAvg");
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 10:
        text = const Text("NOV", style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    // 30, 23, 15, 8, 0
    switch (value.toInt()) {
      case 8:
        text = 'Bad';
        break;
      case 15:
        text = 'Normal';
        break;
      case 23:
        text = 'Good';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      // gridData: FlGridData(
      //   show: true,
      //   horizontalInterval: 1,
      //   verticalInterval: 1,
      //   getDrawingHorizontalLine: (value) {
      //     return const FlLine(
      //       color: AppColors.mainGridLineColor,
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingVerticalLine: (value) {
      //     return const FlLine(
      //       color: AppColors.mainGridLineColor,
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      // gridData: FlGridData(
      //   show: true,
      //   verticalInterval: 1,
      //   horizontalInterval: 1,
      //   getDrawingVerticalLine: (value) {
      //     return const FlLine(
      //       color: Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingHorizontalLine: (value) {
      //     return const FlLine(
      //       color: Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 60,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 29,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 14),
            FlSpot(0, 14),
            FlSpot(2.6, 14),
            FlSpot(4.9, 15),
            FlSpot(6.8, 25),
            FlSpot(8, 8),
            FlSpot(9.5, 20),
            FlSpot(10, 10),
            FlSpot(11, 20),
          ],
          isCurved: true,
          // gradient: LinearGradient(
          //   colors: gradientColors,
          //   begin: Alignment.bottomCenter,
          //   end: Alignment.topCenter,
          // ),
          color: Colors.red,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5))
                  .toList(),
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      // gridData: FlGridData(
      //   show: true,
      //   verticalInterval: 1,
      //   horizontalInterval: 1,
      //   getDrawingVerticalLine: (value) {
      //     return const FlLine(
      //       color: Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      //   getDrawingHorizontalLine: (value) {
      //     return const FlLine(
      //       color: Color(0xff37434d),
      //       strokeWidth: 1,
      //     );
      //   },
      // ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 60,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          // gradient: LinearGradient(
          //   colors: [
          //     ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //         .lerp(0.2)!,
          //     ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //         .lerp(0.2)!,
          //   ],
          // ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(colors: [
              ColorTween(
                begin: gradientColors[0],
                end: gradientColors[1],
              ).lerp(0.2)!.withOpacity(0.1),
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
      ],
    );
  }
}
