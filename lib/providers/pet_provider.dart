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
  double tempMinY = 10;
  double tempMaxY = 40;
  double tempInterval = 10;

  double tempXValue = 0;
  double tempStep = 0.05;

  final _temperatures = <FlSpot>[];
  List<FlSpot> get temperatures => _temperatures;
  void _temperatureGraph() {
    _temperatures.add(FlSpot(tempXValue, _petData.last.temperature));
    if (_petData.length > tempLitmitCount) {
      _temperatures.removeAt(0);
    }
    var temp = _temperatures.last.y;
    if (temp < 0) {
      tempMinY = -20;
      tempMaxY = 40;
      tempInterval = 10;
    } else if (temp >= 0 && temp < 20) {
      tempMinY = 0;
      tempMaxY = 20;
      tempInterval = 4;
    } else if (temp >= 20 && temp < 40) {
      tempMinY = 0;
      tempMaxY = 40;
      tempInterval = 10;
    }

    tempXValue += tempStep;
  }

  // * activity
  int activityLimitCount = 10;
  double actvMinY = 0;
  double actvMaxY = 5;
  double actvInterval = 1;
  double actvXValue = 0;
  double actvStep = 0.05;

  final _activities = <FlSpot>[];
  List<FlSpot> get activities => _activities;
  void _activityGraph() {
    _activities.add(FlSpot(actvXValue, _petData.last.activity.toDouble()));
    if (_petData.length > activityLimitCount) {
      _activities.removeAt(0);
    }
    var actv = _activities.last.y;
    if (actv <= 5) {
      actvMaxY = 10;
    } else if (actv > 5) {
      actvMaxY = 10;
    }
    actvXValue += actvStep;
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
  double pusleInterval = 1;
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
    var pulse = _pulses.last.y;
    if (pulse > pulseMaxY) {
      if (pulse >= 10 && pulse < 20) {
        pusleInterval = 5;
        pulseMaxY = 20;
      } else if (pulse >= 20 && pulse < 50) {
        pusleInterval = 10;
        pulseMaxY = 50;
      } else if (pulse >= 50 && pulse < 100) {
        pusleInterval = 20;
        pulseMaxY = 100;
      } else if (pulse >= 100 && pulse < 200) {
        pusleInterval = 50;
        pulseMaxY = 200;
      } else if (pulse >= 200 && pulse < 500) {
        pusleInterval = 100;
        pulseMaxY = 500;
      } else if (pulse >= 500 && pulse < 1000) {
        pusleInterval = 200;
        pulseMaxY = 1000;
      } else if (pulse >= 1000 && pulse < 5000) {
        pusleInterval = 1000;
        pulseMaxY = 5000;
      } else if (pulse >= 5000 && pulse < 10000) {
        pusleInterval = 2000;
        pulseMaxY = 10000;
      }
    }

    pulseXValue += pulseStep;
  }

  // gait axis
  List<double> _gaitAxisData = [];
  List<double> get gaitAxis => _gaitAxisData;
  void _gaitAxis() {
    Map<String, dynamic> map = _petData.last.gaitAxis.toJson();
    _gaitAxisData = map.values.cast<double>().toList();
  }

  void setGraph() {
    _temperatureGraph();
    _activityGraph();
    _hartGraph();
    _pulseGraph();
    _gaitAxis();
    notifyListeners();
  }
}
