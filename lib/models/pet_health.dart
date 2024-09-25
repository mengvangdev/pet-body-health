import 'package:pet_body_health/models/pet.dart';

class PetHealth {
  final String type;
  final String gender;
  final int age;
  final String size;
  final double weight;
  final int? gait;
  final GaitAxis axis;
  final int activity;
  final double? hartBeat;
  final int hart;
  final int pulse;
  final String? description;
  final DateTime createdAt;

  PetHealth({
    required this.type,
    required this.gender,
    required this.age,
    required this.size,
    required this.weight,
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
    return PetHealth(
      type: json["type"],
      gender: json["gender"],
      age: json["age"],
      size: json["size"],
      weight: json["weight"],
      axis: json["axis"],
      gait: json["gait"],
      activity: json["activity"],
      hartBeat: json["hartBeat"],
      hart: json["hart"],
      pulse: json["pulse"],
      description: json["description"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "gender": gender,
      "age": age,
      "size": size,
      "weight": weight,
      "gait": gait,
      "axis": axis,
      "activity": activity,
      "hartBeat": hartBeat,
      "hart": hart,
      "pulse": pulse,
      "description": description,
      "createdAt": createdAt,
    };
  }
}
