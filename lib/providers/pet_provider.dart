import 'package:pet_body_health/resources/resources.dart';

class PetProvider extends ChangeNotifier {
  List<Pet> _petData = [];

  // getter : pet data
  List<Pet> get petData => _petData;
  // setter : pet data
  set petData(List<Pet> pet) {
    _petData = pet;
    notifyListeners();
  }

  void removeData() {
    _petData.clear();
    _temperatures.clear();
    _activities.clear();
    _harts.clear();
    _pulses.clear();
    notifyListeners();
  }

  // * temperatures
  final tempLitmitCount = 30;
  final double tempMinY = 15;
  final double tempMaxY = 40;
  double tempXValue = 0;
  double tempStep = 0.05;

  final _temperatures = <FlSpot>[];
  List<FlSpot> get temperatures => _temperatures;
  void _temperatureGraph() {
    _temperatures.add(FlSpot(tempXValue, _petData.last.temperature));
    if (_petData.length > tempLitmitCount) {
      _temperatures.removeAt(0);
    }
    tempXValue += tempStep;
  }

  // * activity
  int activityLimitCount = 10;
  double activityMinY = 0;
  double activityMaxY = 5;
  double activityXValue = 0;
  double activityStep = 0.05;

  final _activities = <FlSpot>[];
  List<FlSpot> get activities => _activities;
  void _activityGraph() {
    _activities.add(FlSpot(activityXValue, _petData.last.activity.toDouble()));
    if (_petData.length > activityLimitCount) {
      _activities.removeAt(0);
    }
    if (_activities.last.y >= 5 && _activities.last.y < 10) {
      activityMaxY = 10;
    }
    activityXValue += activityStep;
  }

  // * hart
  int hartLimitCount = 10;
  double hartMinY = 0;
  double hartMaxY = 5;
  double hartXValue = 0;
  double hartStep = 0.05;

  final _harts = <FlSpot>[];
  List<FlSpot> get harts => _harts;
  void _hartGraph() {
    _harts.add(FlSpot(hartXValue, _petData.last.hart.toDouble()));
    if (_petData.length > hartLimitCount) {
      _harts.removeAt(0);
    }
    if (_harts.last.y >= 5 && _harts.last.y < 10) {
      hartMaxY = 10;
    }
    hartXValue += hartStep;
  }

  // * pulse
  final pulseLitmitCount = 30;
  final double pulseMinY = 0;
  double pulseMaxY = 10;
  double pulseXValue = 0;
  double pulseStep = 0.05;

  final _pulses = <FlSpot>[];
  List<FlSpot> get pulses => _pulses;
  void _pulseGraph() {
    _pulses.add(FlSpot(pulseXValue, _petData.last.pulse.toDouble()));
    if (_petData.length > pulseLitmitCount) {
      _petData.removeAt(0);

      _pulses.removeAt(0);
    }
    var length = _pulses.last.y - pulseMaxY;
    if (length > 0) {
      pulseMaxY += length;
    }

    pulseXValue += pulseStep;
  }

  void setGraph() {
    _temperatureGraph();
    _activityGraph();
    _hartGraph();
    _pulseGraph();
    notifyListeners();
  }
}
