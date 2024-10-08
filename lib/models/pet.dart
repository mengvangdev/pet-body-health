class GaitAxis {
  final double gx;
  final double gy;
  final double gz;

  const GaitAxis({required this.gx, required this.gy, required this.gz});
  factory GaitAxis.fromJson(Map<String, dynamic> json){
    return GaitAxis(gx: json["gx"], gy: json["gy"], gz: json["gz"],);

  }

  Map<String, dynamic> toJson() {
    return {
      "gx" : gx,
      "gy" : gy,
      "gz" : gz,
    };
  }
}

class Pet {
  final double temperature;
  final int activity;
  final int pulse;
  final GaitAxis gaitAxis;
  final int hart;

  const Pet({
    required this.temperature,
    required this.activity,
    required this.pulse,
    required this.gaitAxis,
    required this.hart,
  });
}
