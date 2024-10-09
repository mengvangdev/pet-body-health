import 'package:pet_body_health/resources/resources.dart';

class PusleLineChart extends StatefulWidget {
  const PusleLineChart({super.key});

  @override
  State<PusleLineChart> createState() => PusleLineCharthartState();
}

class PusleLineCharthartState extends State<PusleLineChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BleProvider, PetProvider>(
      builder: (context, bleProvider, petProvider, child) {
        if (bleProvider.connected && petProvider.petData.isNotEmpty) {
          final pulse = petProvider.petData.last.pulse;
          final pulses = petProvider.pulses;
          final minY = petProvider.pulseMinY;
          final maxY = petProvider.pulseMaxY;

          // Get max pulse and round it to the nearest higher 10
          final maxPulse = maxY;
          final roundedMaxY =
              (maxPulse / 10).ceil() * 10; // Round up to nearest 10

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  '맥박 : $pulse',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                AspectRatio(
                  aspectRatio: 1.5,
                  child: LineChart(
                    LineChartData(
                      minY: minY,
                      maxY: roundedMaxY.toDouble(),
                      minX: pulses.first.x,
                      maxX: pulses.last.x,
                      lineTouchData: const LineTouchData(enabled: false),
                      clipData: const FlClipData.none(),
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
                        activityLine(pulses),
                      ],
                      // Todo: Text
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
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
                )
              ],
            ),
          );
        }
        return const SizedBox(
          child: Text("Activity is empty"),
        );
      },
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    // Ensure that titles are only multiples of 10
    if (value % 10 == 0) {
      return Text(value.toInt().toString(),
          style: style, textAlign: TextAlign.left);
    }
    return const SizedBox.shrink(); // Hide non-multiples of 10
    // var valueInt = value.toInt();
    // return Text(valueInt.toString(), style: style, textAlign: TextAlign.left);
  }

  LineChartBarData activityLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      gradient: LinearGradient(
        colors: [Colors.orange.withOpacity(0.2), Colors.orange],
        stops: const [0.01, 1.0],
      ),
      barWidth: 3,
      isCurved: true,
      curveSmoothness: 0.5,
      // isStrokeCapRound: true,
    );
  }
}
