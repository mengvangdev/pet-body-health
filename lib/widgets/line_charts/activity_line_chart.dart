import 'package:pet_body_health/resources/resources.dart';

class ActivityLineChart extends StatefulWidget {
  const ActivityLineChart({super.key});

  @override
  State<ActivityLineChart> createState() => ActivityLineCharthartState();
}

class ActivityLineCharthartState extends State<ActivityLineChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<BleProvider, PetProvider>(
      builder: (context, bleProvider, petProvider, child) {
        if (bleProvider.connected && petProvider.petData.isNotEmpty) {
          final activity = petProvider.petData.last.activity;
          final activities = petProvider.activities;
          final minY = petProvider.activityMinY;
          final maxY = petProvider.activityMaxY;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  '활동량 : $activity',
                  style: const TextStyle(
                    color: Colors.blue,
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
                      maxY: maxY,
                      minX: activities.first.x,
                      maxX: activities.last.x,
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
                        activityLine(activities),
                      ],
                      // Todo: Text
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                return leftTitleWidgets(value, meta, activity);
                              }),
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

  Widget leftTitleWidgets(double value, TitleMeta meta, int activity) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    if (activity < 5) {
      switch (value.toInt()) {
        case 0:
          text = '0';
          break;
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
        case 5:
          text = "5";
          break;
        default:
          return Container();
      }
    } else if (activity >= 5 && activity < 10) {
      switch (value.toInt()) {
        case 0:
          text = '0';
          break;
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
        case 10:
          text = '10';
          break;
        default:
          return Container();
      }
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartBarData activityLine(List<FlSpot> points) {
    return LineChartBarData(
        spots: points,
        dotData: const FlDotData(
          show: false,
        ),
        gradient: LinearGradient(
          colors: [Colors.blue.withOpacity(0.2), Colors.blue],
          stops: const [0.01, 1.0],
        ),
        barWidth: 3,
        isCurved: false);
  }
}
