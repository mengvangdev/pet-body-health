import 'package:pet_body_health/resources/resources.dart';

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
                const SizedBox(height: 20),
                Text("activity : $activity"),
                Text("pulse : $pulse"),
                Text("hart : $hart"),
                Text("Gx : ${gaitAxis.gx}"),
                Text("Gy : ${gaitAxis.gy}"),
                Text("Gz : ${gaitAxis.gz}"),

                // RadarChart(),
                // ThreeDAxis(),
                // Temperature2(),
                // LineChartSample2(),
                // SizedBox(height: 20),
                // LineChartSample5(),

                // HeartRate(),
                // HeartState(),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
