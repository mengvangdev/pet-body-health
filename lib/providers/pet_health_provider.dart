import 'dart:developer';

import 'package:pet_body_health/resources/resources.dart';

class PetHealthProvider extends ChangeNotifier {
  PetHealthProvider(this._sharedPref) {
    // removeLocalData();
    read();
    log("pethealth: $_petHealthData");
  }
  final SharedPreferences _sharedPref;
  final String _petHealthKeyName = "petHealth";
  List<String> _petData = [];

  final List<PetHealth> _petHealthData = [];
  List<PetHealth> get petHealthData => _petHealthData;

  void write(PetHealth petHealth) async {
    _petHealthData.add(petHealth);

    // save to local
    Map<String, dynamic> map = petHealth.toJson();
    String jsonData = jsonEncode(map);
    _petData.add(jsonData);
    await _sharedPref.setStringList(_petHealthKeyName, _petData);
    notifyListeners();
  }

  void read() async {
    List<String>? getPetHealth = _sharedPref.getStringList(_petHealthKeyName);
    log("local data: $getPetHealth");
    if (getPetHealth != null) {
      _petData = getPetHealth;
      for (var json in _petData) {
        Map<String, dynamic> map = jsonDecode(json);
        var petHealth = PetHealth.fromJson(map);
        _petHealthData.add(petHealth);
      }
    }
    log("pethealth provider: $_petHealthData");

    notifyListeners();
  }

  void removeLocalData() async {
    await _sharedPref.remove(_petHealthKeyName);
    List<String>? getPetHealth = _sharedPref.getStringList(_petHealthKeyName);
    log("pethealth provider: $getPetHealth");
    notifyListeners();
  }
}
