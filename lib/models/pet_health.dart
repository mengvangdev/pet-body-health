import 'package:pet_body_health/models/pet.dart';

class PetHealth {
  final String type;
  final String gender;
  final int age;
  final String size;
  final double weight;
  final double temperature;
  final int? gait;
  final GaitAxis axis;
  final int activity;
  final double? hartBeat;
  final int pulse;
  final int hart;
  final String? description;
  final DateTime createdAt;

  PetHealth({
    required this.type,
    required this.gender,
    required this.age,
    required this.size,
    required this.weight,
    required this.temperature,
    required this.axis,
    this.gait,
    required this.activity,
    this.hartBeat,
    required this.hart,
    required this.pulse,
    this.description,
    required this.createdAt,
  });

  factory PetHealth.fromJson(Map<String, dynamic> json) {
    // deserialize: map -> object
    GaitAxis axis = GaitAxis.fromJson(json["axis"]);
    DateTime createdAt = DateTime.parse(json["createdAt"]);
    return PetHealth(
      type: json["type"],
      gender: json["gender"],
      age: json["age"],
      size: json["size"],
      weight: json["weight"],
      temperature: json["temperature"],
      axis: axis,
      gait: json["gait"],
      activity: json["activity"],
      hartBeat: json["hartBeat"],
      hart: json["hart"],
      pulse: json["pulse"],
      description: json["description"],
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    // change GaitAxis to map
    var axisMap = axis.toJson();
    var createdAt = this.createdAt.toString();

    return {
      "type": type,
      "gender": gender,
      "age": age,
      "size": size,
      "weight": weight,
      "temperature": temperature,
      "gait": gait,
      "axis": axisMap,
      "activity": activity,
      "hartBeat": hartBeat,
      "hart": hart,
      "pulse": pulse,
      "description": description,
      "createdAt": createdAt,
    };
  }
}
