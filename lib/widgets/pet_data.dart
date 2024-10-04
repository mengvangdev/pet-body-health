import 'package:pet_body_health/resources/resources.dart';
import 'package:pet_body_health/widgets/line_charts/activity_line_chart.dart';
import 'package:pet_body_health/widgets/line_charts/hart_line_chart.dart';
import 'package:pet_body_health/widgets/line_charts/pulse_line_chart.dart';

class PetData extends StatelessWidget {
  const PetData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (context, petProvider, child) {
        if (petProvider.petData.isNotEmpty) {
          // final temperature = petProvider.petData.last.temperature;
          final activity = petProvider.petData.last.activity;
          final pulse = petProvider.petData.last.pulse;
          final hart = petProvider.petData.last.hart;
          final gaitAxis = petProvider.petData.last.gaitAxis;
          return SingleChildScrollView(
            child: Column(
              children: [
                const TemperatureLineChart(),
                const ActivityLineChart(),
                const HartLineChart(),
                const PusleLineChart(),
                const SizedBox(height: 20),
                Text("activity : $activity"),
                Text("pulse : $pulse"),
                Text("hart : $hart"),
                Text("Gx : ${gaitAxis.gx}"),
                Text("Gy : ${gaitAxis.gy}"),
                Text("Gz : ${gaitAxis.gz}"),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
