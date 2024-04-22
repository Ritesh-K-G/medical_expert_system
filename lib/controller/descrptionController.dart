import 'dart:convert';
import 'package:medical_expert_system/models/disease.dart';
import 'package:flutter/services.dart' show rootBundle;

class descriptionController {
  // Map<String, Disease> description;
  final Map<String, Disease> diseases = {};

  Future<void> loadDescription() async {
    String jsonString =
    await rootBundle.loadString('assets/dataset/description.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    jsonMap.forEach((key, value) {
      Disease symptom = Disease.fromJson(value);
      diseases[key] = symptom;
    });
    print(diseases);
  }
}
