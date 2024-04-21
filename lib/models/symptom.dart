class Symptom {
  final String name;
  final int probability;
  final int severity;

  Symptom({required this.name, required this.probability, required this.severity});

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      name: json['name'],
      probability: json['probability'],
      severity: json['severity'],
    );
  }
}