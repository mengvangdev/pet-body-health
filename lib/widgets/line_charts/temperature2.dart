import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pet_body_health/constants/app_colors.dart';
import 'package:pet_body_health/providers/ble_provider.dart';
import 'package:pet_body_health/providers/pet_provider.dart';
import 'package:provider/provider.dart';

class Temperature2 extends StatefulWidget {
  const Temperature2({super.key});

  @override
  State<Temperature2> createState() => _Temperature2State();
}

class _Temperature2State extends State<Temperature2> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    log("reload temperature2.dart");
    return Consumer2<PetProvider, BleProvider>(
        builder: (context, petProvider, bleProvider, child) {
      return AspectRatio(
        aspectRatio: 1.70,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LineChart(mainData(petProvider: petProvider)),
        ),
      );
    });
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
    switch (value.toInt()) {
      case 15:
        text = '15\u00B0C';
        break;
      case 20:
        text = '20\u00B0C';
        break;
      case 25:
        text = '25\u00B0C';
        break;
      case 30:
        text = '30\u00B0C';
        break;
      case 35:
        text = '35\u00B0C';
        break;
      case 40:
        text = '40\u00B0C';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData({required PetProvider petProvider}) {
    final temp = petProvider.temperatures;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        // verticalInterval: 1,
        horizontalInterval: 1,
        // getDrawingVerticalLine: (value) {
        //   return const FlLine(
        //       color: Color(0xff37434d), strokeWidth: 1, dashArray: [2]);
        // },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color.fromARGB(255, 188, 188, 188),
            strokeWidth: 0.5,
            dashArray: [10, 0],
          );
        },
      ),
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
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          bottom: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
        ),
      ),
      minX: temp.first.x,
      maxX: temp.last.y,
      minY: 15,
      maxY: 40,
      lineBarsData: [
        LineChartBarData(
          spots: petProvider.temperatures,
          // spots: const [
          //   FlSpot(0, 15),
          //   FlSpot(1, 22),
          //   FlSpot(2, 23),
          //   FlSpot(3, 23),
          //   FlSpot(4, 28),
          //   FlSpot(5, 28),
          //   FlSpot(6, 25),
          //   FlSpot(7, 25),
          //   FlSpot(8, 30),
          //   FlSpot(9, 33),
          // ],
          isCurved: true,
          gradient: const LinearGradient(
            colors: [
              Colors.blue, // Cool (15°C)
              Colors.orange,
            ],
            tileMode: TileMode.clamp,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),

          // gradient: LinearGradient(
          //   colors: gradientColors,
          // ),
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          // showingIndicators: [2]
          // isStepLineChart: false,
          // aboveBarData: BarAreaData(
          //   show: false,
          // ),
          // belowBarData: BarAreaData(
          //   show: false,
          //   // color: Colors.green,
          //   // gradient: LinearGradient(
          //   //   colors: gradientColors
          //   //       .map((color) => color.withOpacity(0.3))
          //   //       .toList(),
          //   // ),
          // ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
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
          gradient: const LinearGradient(
            // colors: [
            //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
            //       .lerp(0.2)!,
            //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
            //       .lerp(0.2)!,
            // ],
            colors: [Colors.blue, Colors.orange, Colors.red],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
