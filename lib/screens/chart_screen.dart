import 'dart:developer';

import 'package:pet_body_health/resources/resources.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late Timer timer;
  String? message;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 3000),
      (duration) {
        setState(() {
          message =
              context.read<BleProvider>().connected ? null : "IoT기기에 연결해주세요.";
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

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
                    child: message == null
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: themeColor,
                            size: 40,
                          )
                        : Text(
                            message.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: themeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
        );
      },
    );
  }
}
