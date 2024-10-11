import 'package:pet_body_health/resources/resources.dart';

class HartLineChart extends StatefulWidget {
  const HartLineChart({super.key});

  @override
  State<HartLineChart> createState() => _HartLineChartState();
}

class _HartLineChartState extends State<HartLineChart> {
  // List<Color> gradientColors = [
  //   AppColors.contentColorBlue,
  //   AppColors.contentColorCyan,
  //   AppColors.contentColorOrange,
  //   AppColors.contentColorRed,
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<BleProvider, PetProvider>(
        builder: (context, bleProvider, petProvider, child) {
      if (bleProvider.connected && petProvider.petData.isNotEmpty) {
        final hart = petProvider.petData.last.hart;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 12),
              Text(
                '심박상황 : $hart',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  hartLine(petProvider),
                ),
              ),
            ],
          ),
        );
      }
      return const SizedBox(
        child: Text("hart is empty"),
      );
    });
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    String text;
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
        text = '5';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 15,
      child: Text(text, style: style, textAlign: TextAlign.left),
    );
  }

  LineChartData hartLine(PetProvider petProvider) {
    final harts = petProvider.harts;
    final minY = petProvider.hartMinY;
    final maxY = petProvider.hartMaxY;
    final minX = harts.first.x;
    final maxX = harts.last.x;

    return LineChartData(
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
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
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
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineTouchData: const LineTouchData(enabled: false),
      clipData: const FlClipData.none(),
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
        LineChartBarData(
          spots: harts,
          isCurved: true,
          color: Colors.red,
          barWidth: 3,
          // isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          gradient: LinearGradient(
            colors: [Colors.red.withOpacity(0.2), Colors.red],
            stops: const [0.01, 1.0],
          ),
          belowBarData: BarAreaData(
            show: false,
            // gradient: LinearGradient(
            //   colors: gradientColors
            //       .map((color) => color.withOpacity(0.5))
            //       .toList(),
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter,
            // ),
          ),
        ),
      ],
    );
  }
}
