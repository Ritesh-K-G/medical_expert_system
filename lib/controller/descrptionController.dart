import 'dart:convert';
import 'dart:io';
import 'package:medical_expert_system/models/disease.dart';
class descriptionController{
  // Map<String, Disease> description;
  Future<Map<String, Disease>> loadDescription() async {
    // Read the JSON file
    final file = File('assets/dataset/description.json');
    final jsonData = await file.readAsString();

    // Parse JSON
    final Map<String, dynamic> parsedJson = json.decode(jsonData);

    // Create map of Disease objects
    final Map<String, Disease> diseases = {};

    // Loop through each entry in the parsed JSON and create Disease objects
    parsedJson.forEach((key, value) {
      final disease = Disease(
        name: key,
        description: value['english_description'],
        hindiDescription: value['hindi_description'],
        hindiName: value['hindi_name'],
      );
      diseases[key] = disease;
    });

    // return the created map
    return diseases;
  }
}
