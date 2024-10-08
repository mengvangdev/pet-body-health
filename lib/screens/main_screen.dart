import 'dart:math';
import 'dart:developer';
import 'package:pet_body_health/resources/resources.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isCollapsed = true;

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
                          "Cat",
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
                      contentChild: SizedBox(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    detail(title: "성별", data: "암컷"),
                                    const SizedBox(height: 5),
                                    detail(title: "크기", data: "소"),
                                    const SizedBox(height: 5),
                                    detail(title: "걸음걸이", data: "없어요"),
                                    const SizedBox(height: 5),
                                    detail(title: "삼박수", data: "없어요"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    detail(title: "나이", data: "2"),
                                    const SizedBox(height: 5),
                                    detail(title: "무게", data: "4"),
                                    const SizedBox(height: 5),
                                    detail(title: "활동량", data: "5"),
                                    const SizedBox(height: 5),
                                    detail(title: "심박상황", data: "2"),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: description(
                                      title: "상태 저장",
                                      data:
                                          "1. 강아지가 잠을 자고 있을 때 규칙적으로 숨을 들이 마시고 내시는 것을 관찰합시다. 2. 들이마시고 내시는 것을 1회로 1분 동안 측정합니다."),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget detail({required String title, required String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          data,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }

  Widget description({required String title, required String data}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          data,
          style: const TextStyle(fontSize: 16, color: Colors.white),
          maxLines: null,
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
