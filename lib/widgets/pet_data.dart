import 'package:pet_body_health/resources/resources.dart';
import 'package:pet_body_health/widgets/line_charts/activity_line_chart.dart';
import 'package:pet_body_health/widgets/line_charts/hart_line_chart.dart';
import 'package:pet_body_health/widgets/line_charts/pulse_line_chart.dart';
import 'package:pet_body_health/widgets/radar_charts/gait_radar_chart.dart';

class PetData extends StatelessWidget {
  const PetData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, child) {
        if (petProvider.petData.isNotEmpty) {
          final gaitAxis = petProvider.petData.last.gaitAxis;
          return SingleChildScrollView(
            child: Column(
              children: [
                const TemperatureLineChart(),
                const ActivityLineChart(),
                const HartLineChart(),
                const PusleLineChart(),
                const SizedBox(height: 20),
                const RadarChartSample1(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gaitAxisValue(context, "Gx", gaitAxis.gx),
                      gaitAxisValue(context, "Gy", gaitAxis.gy),
                      gaitAxisValue(context, "Gz", gaitAxis.gz),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  SizedBox gaitAxisValue(BuildContext context, String title, double value) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(child: Text("$title : ")),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
