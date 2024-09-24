import 'package:pet_body_health/resources/resources.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BleProvider>(
      builder: (context, bleProvider, child) {
        final connected = bleProvider.connected;
        // final activity = petProvider.petData.last.activity;
        // final pulse = petProvider.petData.last.pulse;
        // final hart = petProvider.petData.last.hart;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              hoverColor: Colors.red,
              constraints: const BoxConstraints.expand(),
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
              ),
            ),
            backgroundColor: themeColor,
            title: const Text(
              "라인 차트",
            ),
            titleTextStyle: const TextStyle(fontSize: 24),
            centerTitle: true,
          ),
          body: connected
              ? const PetData()
              : const SizedBox(
                  child: Center(
                    child: Text("Please connect to device"),
                  ),
                ),
        );
      },
    );
  }
}
