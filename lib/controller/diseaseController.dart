import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:medical_expert_system/models/pair.dart';
import 'package:medical_expert_system/models/symptom.dart';

class DiseaseController{
  Map<String, Map<String, Pair<int, int>>> diseasesMap = {};
  Map<String, Map<String, Pair<int, int>>> tempDataset = {};
  List<String> selectedSymptoms = [];
  Map<String, int> criticalLvl = {};

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
    });

    jsonMap.forEach((key, value) {
      List<dynamic> symptomsJson = value['symptoms'];
      Map<String, Pair<int, int>> symptomsMap = {};
      symptomsJson.forEach((symptomJson) {
        Symptom symptom = Symptom.fromJson(symptomJson);
        symptomsMap[symptom.name] = Pair(symptom.probability, symptom.severity);
      });
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

  void setCritical(String symptom, int lvl) {
    criticalLvl[symptom] = lvl;
  }

  List<String> mySelectedSymptoms() {
    return selectedSymptoms;
  }

  List<Pair<String, Pair<int, int>>> getPotentialDiseases() {
    Map<String, int> criticalLevelObtained = {};
    if (selectedSymptoms.isEmpty) {
      return [];
    }
    List<Pair<double, String>> temp = [];
    diseasesMap.forEach((disease, data) {
      double denom = 0.0;
      double num = 0.0;
      int criticalSum = 0;
      int sever = 0;
      data.forEach((symptom, value) {
        denom += value.first;
        criticalSum += value.second;
        if (selectedSymptoms.contains(symptom)) {
          num += value.first;
          sever += criticalLvl[symptom]!;
        }
      });
      if (sever < (criticalSum / 2)) {
        criticalLevelObtained[disease] = 1;
      }
      else if (sever <= criticalSum) {
        criticalLevelObtained[disease] = 2;
      }
      else {
        criticalLevelObtained[disease] = 3;
      }
      double val = num / denom;
      Pair<double, String> obj = Pair(val, disease);
      temp.add(obj);
    });
    temp.sort((a, b) => b.first.compareTo(a.first));
    List<Pair<String, Pair<int, int>>> potentialDiseases = [];
    for (int i=0; i<min(temp.length, 5); i++) {
      int val = (temp[i].first * 100).toInt();
      Pair<String, Pair<int, int>> obj = Pair(temp[i].second, Pair(val, criticalLevelObtained[temp[i].second]!));
      potentialDiseases.add(obj);
    }
    return potentialDiseases;
  }
}