import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:pet_body_health/resources/resources.dart';

const List<String> sizeItems = ['소', '중', '대'];
const List<String> genderItems = ["수컷", "암컷"];

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  String? selectedGender;
  final _ageController = TextEditingController();
  String? selectedSize;
  final _weightController = TextEditingController();
  final temperatureController = TextEditingController();
  final _gaitController = TextEditingController();
  var activityController = TextEditingController();
  final pulseController = TextEditingController();
  var hartController = TextEditingController();
  final _descriptionController = TextEditingController();

  // validate string : regular expression
  final regexString = RegExp(r"^[a-zA-Z\uAC00-\uD7A3]+$");
  final regexWeight = RegExp(r'^\d{1,3}(\.\d{0,2})?$');
  final regexTemp = RegExp(r'^\d*\.?\d*');
  final regexAge = RegExp(r'^\d{1,2}$');

  @override
  Widget build(BuildContext context) {
    // _typeController.text = "Ehllo";
    double widthScreen = MediaQuery.of(context).size.width;
    return Consumer3<BleProvider, PetProvider, PetHealthProvider>(
      builder: (context, bleProvider, petProvider, petHealthProvider, child) {
        late Pet petData;
        if (petProvider.petData.isNotEmpty) {
          petData = petProvider.petData.last;
          temperatureController.text = petData.temperature.toString();
          activityController.text = petData.activity.toString();
          pulseController.text = petData.pulse.toString();
          hartController.text = petData.hart.toString();
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("펫케어"),
              centerTitle: true,
              titleTextStyle: const TextStyle(fontSize: 24),
              backgroundColor: themeColor,
              shadowColor: Colors.black,
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
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 50),
                  child: Form(
                    key: _formKey,
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
                                  child: typeField(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("성별"),
                                SizedBox(
                                  width: widthScreen * 0.45, // 45% of screen
                                  child: genderField(),
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
                                  child: ageField(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("크기"),
                                SizedBox(
                                  width: widthScreen * 0.45,
                                  child: sizeField(),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("무게"),
                                SizedBox(
                                  width: widthScreen * 0.45,
                                  child: weightField(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("체온"),
                                SizedBox(
                                  width: widthScreen * 0.45,
                                  child: temperatureField(),
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
                                  child: gaitField(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("활동량"),
                                SizedBox(
                                  width: widthScreen * 0.45,
                                  child: activityField(),
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
                                const Text("맥박"),
                                SizedBox(
                                  width: widthScreen * 0.45,
                                  child: pulseField(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("심박상황"),
                                SizedBox(
                                  width: widthScreen * 0.45,
                                  child: hartField(),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //
                        const SizedBox(height: 20),
                        const Text("상태 저장"),
                        SizedBox(
                          child: descriptionField(),
                        ),
                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: widthScreen * 0.45,
                            //   child: GFButton(
                            //     onPressed: () {},
                            //     animationDuration: Durations.long1,
                            //     buttonBoxShadow: true,
                            //     color: themeColor,
                            //     textColor: Colors.white,
                            //     size: 44,
                            //     shape: GFButtonShape.pills,
                            //     child: const Text(
                            //       "측정",
                            //       style: TextStyle(fontSize: 24),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: widthScreen * 0.45,
                              child: GFButton(
                                animationDuration: Durations.extralong1,
                                buttonBoxShadow: true,
                                color: themeColor,
                                textColor: Colors.white,
                                size: 44,
                                shape: GFButtonShape.pills,
                                child: const Text(
                                  "저장",
                                  style: TextStyle(fontSize: 24),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // check description
                                    String? description;
                                    if (_descriptionController
                                        .text.isNotEmpty) {
                                      description = _descriptionController.text;
                                    }
                                    var type = _typeController.text;
                                    var gender = selectedGender!;
                                    var age = int.parse(_ageController.text);
                                    var size = selectedSize!;
                                    var weight =
                                        double.parse(_weightController.text);
                                    var temperature = petData.temperature;
                                    var gait = int.parse(_gaitController.text);
                                    var axis = GaitAxis(
                                        gx: petData.gaitAxis.gx,
                                        gy: petData.gaitAxis.gy,
                                        gz: petData.gaitAxis.gz);
                                    var activity = petData.activity;
                                    var pulse = petData.pulse;
                                    var hart = petData.hart;

                                    var petHealth = PetHealth(
                                      type: type,
                                      gender: gender,
                                      age: age,
                                      size: size,
                                      weight: weight,
                                      temperature: temperature,
                                      gait: gait,
                                      axis: axis,
                                      activity: activity,
                                      pulse: pulse,
                                      hart: hart,
                                      description: description,
                                      createdAt: DateTime.now(),
                                    );
                                    petHealthProvider.write(petHealth);
                                    log("-------- Successfully ----------");

                                    // reset all value in fields
                                    _typeController.clear();
                                    _ageController.clear();
                                    _weightController.clear();
                                    _gaitController.clear();
                                    _descriptionController.clear();
                                    selectedGender = null;
                                    selectedSize = null;

                                    // Unfocus all text fields
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // type field
  TextFormField typeField() {
    return TextFormField(
      controller: _typeController,
      keyboardType: TextInputType.visiblePassword,
      cursorHeight: 28,
      cursorColor: _typeController.text.isEmpty ? unfocusedColor : focusedColor,
      cursorErrorColor:
          _typeController.text.isEmpty ? errorColor : focusedColor,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        text: _typeController.text,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate type: $value");
          return '';
        }
        return null;
      },
      onChanged: (value) {
        if (regexString.hasMatch(value)) {
          setState(() {
            // _typeController.text = value;
          });
        } else {
          setState(() {
            // _typeController.text = value;
          });
        }
      },
      //onSaved: (newValue) {
      // log("save: $newValue");
      // _typeController.text = newValue!;
      //},
    );
  }

  // gender field
  DropdownButtonFormField2<String> genderField() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: selectedGender,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        enabledBorder: selectedGender != null
            ? stateColor(focusedColor)
            : stateColor(unfocusedColor),
        focusedBorder: selectedGender != null
            ? stateColor(focusedColor)
            : stateColor(unfocusedColor),
        errorBorder: selectedGender != null
            ? stateColor(focusedColor)
            : stateColor(errorColor),
        focusedErrorBorder: selectedGender != null
            ? stateColor(focusedColor)
            : stateColor(errorColor),
        errorStyle: const TextStyle(height: 0),
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
        if (value == null || value.isEmpty) {
          log("validate gender: $value");
          return '';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
      // onSaved: (value) {
      //   selectedGender = value;
      // },
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
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  // age field
  TextFormField ageField() {
    return TextFormField(
      controller: _ageController,
      keyboardType: TextInputType.number,
      cursorHeight: 28,
      cursorColor: _ageController.text.isEmpty ? unfocusedColor : focusedColor,
      cursorErrorColor: _ageController.text.isEmpty ? errorColor : focusedColor,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        text: _ageController.text,
        textLength: _ageController.text.length,
      ),
      inputFormatters: [FilteringTextInputFormatter.allow(regexAge)],
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate age: $value");
          return '';
        }
        return null;
      },
      onChanged: (value) {
        if (regexAge.hasMatch(value)) {
          // value is not empty, field is green, validated
          log(value.toString());
          setState(() {
            // _ageController.text = value;
          });
        } else {
          // call setState to get invalidated or  error border when field is empty
          setState(() {
            // _ageController.text = value;
          });
        }
        log(value.length.toString());
      },
    );
  }

  // size field
  DropdownButtonFormField2<String> sizeField() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: selectedSize,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        enabledBorder: selectedSize != null
            ? stateColor(focusedColor)
            : stateColor(unfocusedColor),
        focusedBorder: selectedSize != null
            ? stateColor(focusedColor)
            : stateColor(unfocusedColor),
        errorBorder: selectedSize != null
            ? stateColor(focusedColor)
            : stateColor(errorColor),
        focusedErrorBorder: selectedSize != null
            ? stateColor(focusedColor)
            : stateColor(errorColor),
        errorStyle: const TextStyle(height: 0),
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
        if (value == null || value.isEmpty) {
          log("validate size: $value");
          return '';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedSize = value;
        });
      },
      // onSaved: (value) {
      //   selectedSize = value!;
      // },
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
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  // weight field
  TextFormField weightField() {
    return TextFormField(
      controller: _weightController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      cursorHeight: 28,
      cursorColor:
          _weightController.text.isEmpty ? unfocusedColor : focusedColor,
      cursorErrorColor:
          _weightController.text.isEmpty ? errorColor : focusedColor,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        weightSuffix: true,
        text: _weightController.text,
      ),
      inputFormatters: [FilteringTextInputFormatter.allow(regexWeight)],
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate weight: $value");
          return '';
        }
        return null;
      },
      onChanged: (value) {
        if (regexWeight.hasMatch(value)) {
          setState(() {});
        } else {
          setState(() {});
        }
      },
    );
  }

  // temperature field
  TextFormField temperatureField() {
    return TextFormField(
      controller: temperatureController,
      readOnly: true,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        temperatureSuffix: true,
        text: temperatureController.text,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate temperature: $value");
          return '';
        }
        return null;
      },
      onChanged: (value) {
        if (regexTemp.hasMatch(value)) {
          setState(() {});
        } else {
          setState(() {});
        }
      },
    );
  }

  // gait field
  TextFormField gaitField() {
    return TextFormField(
      controller: _gaitController,
      keyboardType: TextInputType.number,
      cursorHeight: 28,
      cursorColor: _gaitController.text.isEmpty ? unfocusedColor : focusedColor,
      cursorErrorColor:
          _gaitController.text.isEmpty ? errorColor : focusedColor,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        text: _gaitController.text,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate gait: $value");
          return '';
        }
        return null;
      },
    );
  }

  // activity field
  TextFormField activityField() {
    return TextFormField(
      controller: activityController,
      readOnly: true,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        text: activityController.text,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate activity: $value");
          return '';
        }
        return null;
      },
    );
  }

  // pulse field
  TextFormField pulseField() {
    return TextFormField(
      controller: pulseController,
      readOnly: true,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        text: pulseController.text,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate pulse: $value");
          return '';
        }
        return null;
      },
    );
  }

  // hart state field
  TextFormField hartField() {
    return TextFormField(
      controller: hartController,
      readOnly: true,
      style: const TextStyle(fontSize: 18.0),
      decoration: inputDecoration(
        text: hartController.text,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          log("validate hart: $value");
          return '';
        }
        return null;
      },
    );
  }

// description field
  TextFormField descriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 3,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(fontSize: 18.0),
      decoration: InputDecoration(
        enabledBorder: _descriptionController.text.isEmpty
            ? stateColor(unfocusedColor)
            : stateColor(focusedColor),
        focusedBorder: _descriptionController.text.isEmpty
            ? stateColor(unfocusedColor)
            : stateColor(focusedColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }

  InputDecoration inputDecoration(
      {required String text,
      int? textLength,
      bool? weightSuffix,
      bool? temperatureSuffix}) {
    return InputDecoration(
      enabledBorder: text.isNotEmpty
          ? stateColor(focusedColor)
          : stateColor(unfocusedColor),
      focusedBorder: text.isNotEmpty
          ? stateColor(focusedColor)
          : stateColor(unfocusedColor),
      errorBorder:
          text.isNotEmpty ? stateColor(focusedColor) : stateColor(errorColor),
      focusedErrorBorder:
          text.isNotEmpty ? stateColor(focusedColor) : stateColor(errorColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      errorStyle: const TextStyle(
        fontSize: 0,
        // decoration: TextDecoration.none,
        height: 0,
      ),
      suffix: weightSuffix != null
          ? const Text("Kg")
          : temperatureSuffix != null
              ? const Text("\u00B0C")
              : null,
    );
  }

  OutlineInputBorder stateColor(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1.8, color: color),
    );
  }
}
