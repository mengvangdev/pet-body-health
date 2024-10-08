import 'dart:developer';

import 'package:pet_body_health/resources/resources.dart';

class PetHealthProvider extends ChangeNotifier {
  PetHealthProvider(this._sharedPref){
    read();
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

  void read() {
    List<String>? getPetHealth = _sharedPref.getStringList(_petHealthKeyName);
    if (getPetHealth != null) {
      _petData = getPetHealth;
    _petData.map((json) {
      var map = jsonDecode(json);
      var petHealth = PetHealth.fromJson(map);
      _petHealthData.add(petHealth);

    });
      
    }
    notifyListeners();
  }
}
