import 'dart:developer';

import 'package:pet_body_health/constants/app_colors.dart';
import 'package:pet_body_health/resources/resources.dart';

class TemperatureLineChart extends StatefulWidget {
  const TemperatureLineChart({super.key});

  final Color sinColor = AppColors.contentColorBlue;
  final Color cosColor = AppColors.contentColorPink;

  @override
  State<TemperatureLineChart> createState() => _TemperatureLineChartState();
}

class _TemperatureLineChartState extends State<TemperatureLineChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BleProvider, PetProvider>(
      builder: (context, bleProvider, petProvider, child) {
        if (bleProvider.connected && petProvider.petData.isNotEmpty) {
          final temperature = petProvider.petData.last.temperature;
          final temperatures = petProvider.temperatures;
          final minY = petProvider.minY;
          final maxY = petProvider.maxY;

          log(petProvider.petData.length.toString());
          log("temps: ${petProvider.temperatures}");

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  '온도: $temperature',
                  style: const TextStyle(
                    color: Colors.green,
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
                        minY: minY,
                        maxY: maxY,
                        minX: temperatures.first.x,
                        maxX: temperatures.last.x,
                        lineTouchData: const LineTouchData(enabled: false),
                        clipData: const FlClipData.all(),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          drawHorizontalLine: false,
                          getDrawingHorizontalLine: (value) {
                            return const FlLine(
                              color: Color.fromARGB(255, 188, 188, 188),
                              strokeWidth: 0.5,
                              dashArray: [10, 0],
                            );
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 188, 188, 188),
                            ),
                            // top: BorderSide(
                            //   width: 0.5,
                            //   color: Color.fromARGB(255, 188, 188, 188),
                            // ),
                            bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 188, 188, 188),
                            ),
                          ),
                        ),
                        lineBarsData: [
                          temperatureLine(temperatures),
                        ],
                        // Todo: Text
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 42,
                              getTitlesWidget: leftTitleWidgets,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox(
          child: Text("Temperature is empty"),
        );
      },
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

  LineChartBarData temperatureLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [Colors.green.withOpacity(0.2), Colors.green],
        stops: const [0.1, 1.0],
      ),
      barWidth: 3,
      isCurved: true,
    );
  }
}
