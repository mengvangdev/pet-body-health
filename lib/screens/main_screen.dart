import 'package:pet_body_health/resources/resources.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<PetProvider, PetHealthProvider, BleProvider>(
        builder: (context, petProvider, petHealthProvider, bleProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("펫케어"),
          centerTitle: true,
          titleTextStyle: const TextStyle(fontSize: 24),
          backgroundColor: themeColor,
          shadowColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                bleProvider.connection();
              },
              padding: const EdgeInsets.all(0),
              icon: Image.asset(
                "assets/icons/bluetooth-off.png",
                width: 40,
                height: 40,
              ),
              isSelected: bleProvider.connected,
              selectedIcon: Image.asset(
                "assets/icons/bluetooth-on.png",
                width: 40,
                height: 40,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChartScreen(),
                  ),
                );
              },
              icon: Image.asset(
                "assets/icons/line-chart.png",
                width: 30,
                height: 30,
                color: Colors.white,
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     petHealthProvider.removeLocalData();
            //   },
            //   icon: const Icon(Icons.remove_circle_outline),
            // ),
            // IconButton(
            //   onPressed: () {
            //     petHealthProvider.read();
            //   },
            //   icon: const Icon(Icons.read_more),
            // ),
          ],
        ),
        body: petHealthProvider.petHealthData.isNotEmpty
            ? ListView.builder(
                itemCount: petHealthProvider.petHealthData.length,
                itemBuilder: (context, index) {
                  var petHealthSnapshot =
                      petHealthProvider.petHealthData[index];
                  return DataListView(petHealth: petHealthSnapshot);
                })
            : Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: themeColor,
                  size: 40,
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FormScreen(),
              ),
            );
            // petHealthProvider.read();
          },
          backgroundColor: themeColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),
      );
    });
  }
}
