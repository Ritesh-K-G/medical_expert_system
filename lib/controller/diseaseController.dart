import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:medical_expert_system/models/pair.dart';
import 'package:medical_expert_system/models/symptom.dart';

class DiseaseController{
  Map<String, Map<String, Pair<int, int>>> diseasesMap = {};
  Map<String, Map<String, Pair<int, int>>> tempDataset = {};
  List<String> selectedSymptoms = [];

  Future<void> loadDiseasesData() async {
    String jsonString = await rootBundle.loadString('assets/dataset/dataset.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    jsonMap.forEach((key, value) {
      List<dynamic> symptomsJson = value['symptoms'];
      Map<String, Pair<int, int>> symptomsMap = {};
      symptomsJson.forEach((symptomJson) {
        Symptom symptom = Symptom.fromJson(symptomJson);
        symptomsMap[symptom.name] = Pair(symptom.probability, symptom.severity);
      });
      diseasesMap[key] = symptomsMap;
      tempDataset[key] = symptomsMap;
    });
  }

  List<String> getSymptoms() {
    List<String> symptoms = [];
    Map<String, int> symptomsProbabSum = {};
    tempDataset.forEach((disease, symptoms) {
      symptoms.forEach((symptom, value) {
        symptomsProbabSum[symptom] = symptomsProbabSum.containsKey(symptom)
            ? symptomsProbabSum[symptom]! + value.first
            : value.first;
      });
    });
    List<Pair<int, String>> probabSumList = [];
    symptomsProbabSum.forEach((symptom, value) {
      Pair<int, String> obj = Pair(value, symptom);
      probabSumList.add(obj);
    });
    probabSumList.sort((a, b) => b.first.compareTo(a.first));
    for (int i=0; i<min(probabSumList.length, 5); i++) {
      symptoms.add(probabSumList[i].second);
    }
    return symptoms;
  }

  void selectSymptom(String symptom) {
    selectedSymptoms.add(symptom);
    tempDataset.removeWhere((disease, data) => !data.containsKey(symptom));
    List<String> toDelete = [];
    toDelete.add(symptom);
    deleteSymptoms(toDelete);
  }

  void deleteSymptoms(List<String> symptoms) {
    tempDataset.forEach((disease, data) {
      for (var symptom in symptoms) {
        if (data.containsKey(symptom)) {
          data.remove(symptom);
        }
      }
    });
  }

  List<String> mySelectedSymptoms() {
    return selectedSymptoms;
  }

  List<Pair<String, int>> getPotentialDiseases() {
    List<Pair<double, String>> temp = [];
    diseasesMap.forEach((disease, data) {
      double denom = 0.0;
      double num = 0.0;
      data.forEach((symptom, value) {
        denom += value.first;
        if (selectedSymptoms.contains(symptom)) {
          num += value.first;
        }
      });
      double val = num / denom;
      Pair<double, String> obj = Pair(val, disease);
      temp.add(obj);
    });
    temp.sort((a, b) => b.first.compareTo(a.first));
    List<Pair<String, int>> potentialDiseases = [];
    for (int i=0; i<min(temp.length, 10); i++) {
      int val = (temp[i].first * 100).toInt();
      Pair<String, int> obj = Pair(temp[i].second, val);
      potentialDiseases.add(obj);
    }
    return potentialDiseases;
  }
}