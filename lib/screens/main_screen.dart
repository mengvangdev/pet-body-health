import 'dart:developer';

import 'package:pet_body_health/resources/resources.dart';

const List<String> sizeItems = ['소', '중', '대'];
const List<String> genderItems = ["수컷", "암컷"];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _typeController = TextEditingController();
  String? selectedGender;
  final _ageController = TextEditingController();
  String? selectedSize;
  final _weightController = TextEditingController();
  final _gaitController = TextEditingController();
  var activityController = TextEditingController();
  var hartController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Consumer2<PetProvider, BleProvider>(
      builder: (context, petProvider, bleProvider, child) {
        if (petProvider.petData.isNotEmpty) {
          activityController.text =
              petProvider.petData.last.activity.toString();
          hartController.text = petProvider.petData.last.hart.toString();
        }
        log("main_screen bluetooth state: ${bleProvider.connected}");
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
              child: SizedBox(
                // decoration: const BoxDecoration(
                //   gradient: LinearGradient(
                //       colors: [Color(0xffeaf4e0), Color(0xffc5e4d4)],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter),
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("종류"),
                              SizedBox(
                                width: widthScreen * 0.45, // 45% of screen
                                child: textFormField(
                                    controller: _typeController,
                                    readOnly: false,
                                    textInputType:
                                        TextInputType.visiblePassword),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("성별"),
                              SizedBox(
                                width: widthScreen * 0.45, // 45% of screen
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    enabledBorder: enabledBorder(),
                                    focusedBorder: focusedBorder(),
                                  ),
                                  hint: const Text(
                                    '선택',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  items: genderItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select gender.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //Do something when selected item is changed.
                                  },
                                  onSaved: (value) {
                                    selectedGender = value!;
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("나이"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: textFormField(
                                    controller: _ageController,
                                    readOnly: false,
                                    textInputType: TextInputType.number),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("크기"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    enabledBorder: enabledBorder(),
                                    focusedBorder: focusedBorder(),
                                  ),
                                  hint: const Text(
                                    '선택',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  items: sizeItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select gender.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //Do something when selected item is changed.
                                  },
                                  onSaved: (value) {
                                    selectedSize = value!;
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black45,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("무게"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: textFormField(
                                    controller: _weightController,
                                    readOnly: false,
                                    textInputType: TextInputType.number,
                                    suffix: true),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // activity
                      const Text(
                        "활동 *",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("걸음걸이"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: textFormField(
                                    controller: _gaitController,
                                    readOnly: true,
                                    textInputType: TextInputType.number),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("활동량"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: textFormField(
                                    controller: activityController,
                                    readOnly: true,
                                    textInputType: TextInputType.number),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // heart rate
                      const Text(
                        "심박수 *",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("삼박수"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: textFormField(
                                    controller: _gaitController,
                                    readOnly: true,
                                    textInputType: TextInputType.number),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("심박상황"),
                              SizedBox(
                                width: widthScreen * 0.45,
                                child: textFormField(
                                    controller: hartController,
                                    readOnly: true,
                                    textInputType: TextInputType.number),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //
                      const SizedBox(height: 20),
                      const Text("상태 저장"),
                      SizedBox(
                        child: TextFormField(
                          maxLines: 3,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                            enabledBorder: enabledBorder(),
                            focusedBorder: focusedBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widthScreen * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "측정",
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () {
                                bleProvider.loadData();
                              },
                            ),
                          ),
                          SizedBox(
                            width: widthScreen * 0.45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "저장",
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () {
                                bleProvider.saveData();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {},
            //   child: Image.asset(
            //     "assets/line-chart.png",
            //   ),
            // ),
          ),
        );
      },
    );
  }

  TextFormField textFormField(
      {required controller,
      required bool readOnly,
      required TextInputType textInputType,
      required,
      bool? suffix = false}) {
    return TextFormField(
      cursorHeight: 30,
      readOnly: readOnly,
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(suffix!),
    );
  }

  InputDecoration inputDecoration(bool isSuffix) {
    return InputDecoration(
      enabledBorder: enabledBorder(),
      focusedBorder: focusedBorder(),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      suffix: isSuffix ? const Text("Kg") : null,
    );
  }

  OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.8, color: unfocusedBorderColor),
    );
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1.8, color: focusedBorderColor),
    );
  }
}