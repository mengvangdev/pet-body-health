import 'dart:math';
import 'dart:developer';
import 'package:getwidget/getwidget.dart';
import 'package:pet_body_health/resources/resources.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<PetProvider, BleProvider>(
        builder: (context, petProvider, bleProvider, child) {
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
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the card
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Position of the shadow
                        ),
                      ],
                    ),
                    child: GFAccordion(
                      titleChild: Container(
                        padding: const EdgeInsets.all(
                            8), // Padding for title content
                        child: const Text("HEllo"),
                      ),
                      content: "Hello",
                      expandedTitleBackgroundColor: Colors.orange.shade100,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: themeColor, // Background color of the card
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Position of the shadow
                        ),
                      ],
                    ),
                    child: GFAccordion(
                      onToggleCollapsed: (isCollapsed) {
                        setState(() {
                          this.isCollapsed = !isCollapsed;
                        });
                      },
                      collapsedTitleBackgroundColor: themeColor,
                      expandedTitleBackgroundColor: Colors.white,
                      titleBorderRadius: BorderRadius.circular(8),
                      titleChild: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Flutter",
                          style: TextStyle(
                            color: isCollapsed ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      collapsedIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 24,
                        color: Colors.white,
                      ),
                      expandedIcon: const Icon(
                        Icons.keyboard_arrow_up,
                        size: 24,
                        color: Colors.black,
                      ),
                      contentBackgroundColor: themeColor,
                      contentChild: Column(
                        children: [
                          Row(
                            children: [
                              Text("Flutter"),
                              Text("Unity"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
