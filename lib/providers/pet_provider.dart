import 'package:pet_body_health/resources/resources.dart';

class PetProvider extends ChangeNotifier {
  List<Pet> _petData = [];

  // * temperatures
  final limitCount = 30;
  final double minY = 15;
  final double maxY = 40;
  double xValue = 0;
  double step = 0.05;

  // getter : pet data
  List<Pet> get petData => _petData;
  // setter : pet data
  set petData(List<Pet> pet) {
    _petData = pet;
    notifyListeners();
  }

  final _temperatures = <FlSpot>[];
  List<FlSpot> get temperatures => _temperatures;
  void temperatureGraph() {
    _temperatures.add(FlSpot(xValue, _petData.last.temperature));
    if (_petData.length > limitCount) {
      _petData.removeAt(0);
      _temperatures.removeAt(0);
    }
    xValue += step;
    notifyListeners();
  }
}
