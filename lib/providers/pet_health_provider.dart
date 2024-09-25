import 'package:pet_body_health/resources/resources.dart';

class PetHealthProvider extends ChangeNotifier {
  PetHealthProvider(this.sharedPref) {
    read();
  }
  final SharedPreferences sharedPref;
  final String petHealthKeyName = "petHealth";
  List<String> petHealthData = [];

  void write(PetHealth petHealth) async {
    Map<String, dynamic> map = petHealth.toJson();
    String jsonData = jsonEncode(map);
    petHealthData.add(jsonData);
    await sharedPref.setStringList(petHealthKeyName, petHealthData);
  }

  void read() {
    List<String>? getPetHealth = sharedPref.getStringList(petHealthKeyName);
    if (getPetHealth == null) {
      return;
    }
    petHealthData = getPetHealth;
  }
}
