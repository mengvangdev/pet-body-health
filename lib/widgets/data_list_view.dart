import 'package:intl/intl.dart';
import 'package:pet_body_health/resources/resources.dart';

class DataListView extends StatefulWidget {
  const DataListView({super.key, required this.petHealth});

  final PetHealth petHealth;

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    var data = widget.petHealth;

    // change datetime format
    var createdAt = data.createdAt;
    var date = DateFormat('d/MM/yyyy').format(createdAt);
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
              margin: const EdgeInsets.all(8),
              titlePadding:
                  const EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 8),
              onToggleCollapsed: (isCollapsed) {
                setState(() {
                  this.isCollapsed = !isCollapsed;
                });
              },
              collapsedTitleBackgroundColor: themeColor,
              expandedTitleBackgroundColor: Colors.white,
              titleBorderRadius: BorderRadius.circular(8),
              titleChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    data.type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: isCollapsed ? Colors.white : themeColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isCollapsed ? Colors.white : themeColor,
                      ),
                    ),
                  ),
                ],
              ),
              collapsedIcon: const Icon(
                Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.white,
              ),
              expandedIcon: const Icon(
                Icons.keyboard_arrow_up,
                size: 24,
                color: themeColor,
              ),
              contentBackgroundColor: themeColor,
              contentChild: SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            detail(title: "성별", data: data.gender),
                            const SizedBox(height: 5),
                            detail(title: "크기", data: data.size),
                            const SizedBox(height: 5),
                            detail(
                                title: "체온", data: data.temperature.toString()),
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
                            detail(
                                title: "활동량", data: data.activity.toString()),
                            const SizedBox(height: 5),
                            detail(title: "심박상황", data: data.hart.toString()),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    data.description != null
                        ? const Divider(
                            color: Colors.white,
                            thickness: 2,
                          )
                        : Container(),
                    data.description != null
                        ? Row(
                            children: [
                              Expanded(
                                child: description(
                                  title: "상태 저장",
                                  data: data.description!,
                                ),
                              ),
                            ],
                          )
                        : Container(),
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
          setText(title, data),
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

  String setText(String title, String data) {
    if (title == "무게") {
      var value = double.parse(data);
      // change weight #.0 format to int: 2.0 -> 2
      if (value == value.roundToDouble()) {
        return "${value.toInt()} Kg";
      }
      return "$data Kg";
    } else if (title == "체온") {
      var value = double.parse(data);
      // change weight #.0 format to int: 2.0 -> 2
      if (value == value.roundToDouble()) {
        return "${value.toInt()} \u00B0C";
      }
      return "$data \u00B0C";
    } else {
      return data;
    }
  }
}
