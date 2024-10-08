import 'dart:developer';
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
          ],
        ),
        body: petHealthProvider.petHealthData.isNotEmpty ? ListView.builder(
          itemCount: petHealthProvider.petHealthData.length,
          itemBuilder: (context, index) {
            var petHealthSnapshot = petHealthProvider.petHealthData[index];
            return DataListView(petHealth: petHealthSnapshot);
        }) : Center(child: LoadingAnimationWidget.fourRotatingDots(
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
          },
          backgroundColor: themeColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),
      ) ;
    });
  }


}

class DataListView extends StatefulWidget {
  const DataListView({
    super.key,
    required this.petHealth
  });

  final PetHealth petHealth;

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {

  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
            var data = widget.petHealth;
            return Padding(
            padding: const EdgeInsets.all(8.0),
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
                        isCollapsed = !isCollapsed;
                      });
                    },
                    collapsedTitleBackgroundColor: themeColor,
                    expandedTitleBackgroundColor: Colors.white,
                    titleBorderRadius: BorderRadius.circular(8),
                    titleChild: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        data.type,
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
                                  detail(title: "성별", data: data.gender),
                                  const SizedBox(height: 5),
                                  detail(title: "크기", data: data.size),
                                  const SizedBox(height: 5),
                                  detail(title: "걸음걸이", data: data.gait.toString()),
                                  const SizedBox(height: 5),
                                  detail(title: "맥박", data: data.pulse.toString()),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  detail(title: "나이", data: data.age.toString()),
                                  const SizedBox(height: 5),
                                  detail(title: "무게", data: data.weight.toString()),
                                  const SizedBox(height: 5),
                                  detail(title: "활동량", data: data.activity.toString()),
                                  const SizedBox(height: 5),
                                  detail(title: "심박상황", data: data.hart.toString()),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                            data.description!.isNotEmpty ? 
                          const Divider(
                            color: Colors.white,
                            thickness: 2,
                          ): Container(),
                               data.description!.isNotEmpty ? 
                          Row(
                            children: [
                              Expanded(
                                child: description(
                                    title: "상태 저장",
                                    data: data.description!,),
                              ),
                            ],
                          ) : Container(),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
       
       
        
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


