//this code is not final one
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';

class DiseaseChecker {
  Map<String, Map<String, Map<String, List<int>>>> mp = {};
  Map<String, Map<String, Map<String, List<int>>>> mpTemp = {};
  Set<String> symptoms = {};
  Set<String> diseases = {};
  Set<String> selectedSymptoms = {};

  Set<String> firstScreen(Map<String, Map<String, Map<String, List<int>>>> data) {
    Map<String, int> symptomProbabilitySum = {};

    data.forEach((disease, symptomMap) {
      symptomMap.forEach((symptom, pair) {
        symptomProbabilitySum[symptom] ??= 0;
        symptomProbabilitySum[symptom] += pair[0];
      });
    });

    List<MapEntry<String, int>> sortedEntries = symptomProbabilitySum.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries.sublist(0, 5).map((entry) => entry.key).toSet();
  }

  Set<String> probabilitySum(Map<String, Map<String, Map<String, List<int>>>> data) {
    Map<String, int> symptomProbabilitySum = {};

    data.forEach((disease, symptomMap) {
      symptomMap.forEach((symptom, pair) {
        symptomProbabilitySum[symptom] ??= 0;
        symptomProbabilitySum[symptom] += pair[0];
      });
    });

    List<MapEntry<String, int>> sortedEntries = symptomProbabilitySum.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries.sublist(0, 5).map((entry) => entry.key).toSet();
  }

  void consequenceScreens(String inputSymptom) {
    if (mpTemp.containsKey(inputSymptom)) {
      // Remove diseases not having the input symptom
      mpTemp.removeWhere((disease, symptomMap) => !symptomMap.containsKey(inputSymptom));

      // Remove input symptom from remaining diseases
      mpTemp.forEach((disease, symptomMap) => symptomMap.remove(inputSymptom));

      probabilitySum(mpTemp);
    } else if (inputSymptom == "none of these") {
      // Remove diseases having any of the previously selected symptoms
      mpTemp.removeWhere((disease, symptomMap) => symptomMap.keys.toSet().intersection(selectedSymptoms).isNotEmpty);

      probabilitySum(mpTemp);
    } else if (inputSymptom == "I haven't any of the symptom left") {
      // Return selected symptoms and print diseases
      print("Selected Symptoms: $selectedSymptoms");

      List<String> sortedDiseases = diseases.toList();
      sortedDiseases.sort((a, b) {
        // Compare diseases based on the sum of probability of selected symptoms
        int sumA = 0;
        int sumB = 0;
        selectedSymptoms.forEach((symptom) {
          if (mp[a][symptom] != null) {
            sumA += mp[a][symptom][0];
          }
          if (mp[b][symptom] != null) {
            sumB += mp[b][symptom][0];
          }
        });
        return sumB.compareTo(sumA);
      });

      print("Possible Diseases:");
      for (String disease in sortedDiseases) {
        print("$disease");
      }

      // Terminate
      return;
    }
  }
}

void main() {
  // Example usage
  DiseaseChecker checker = DiseaseChecker();

  // Assuming you have loaded your data into mp and mpTemp
  // JSON parsing can be done here

  // Example input
  String inputSymptom = "Fever";
  checker.consequenceScreens(inputSymptom);
}
