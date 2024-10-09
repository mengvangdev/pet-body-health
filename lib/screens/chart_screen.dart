import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pet_body_health/resources/resources.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BleProvider>(
      builder: (context, bleProvider, child) {
        final connected = bleProvider.connected;
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
              : SizedBox(
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: themeColor,
                      size: 40,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
