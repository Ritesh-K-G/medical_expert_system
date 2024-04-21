import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:collection';

class SymptomSelector {
  Map<String, Map<String, List<int>>> mp;
  Map<String, Map<String, List<int>>> mpTemp;
  List<String> selectedSymptoms = [];

  SymptomSelector(this.mp) {
    mpTemp = Map.from(mp);
  }

  int probabilitySum(String symptom, Map<String, Map<String, List<int>>> map) {
    int sum = 0;
    if (map.containsKey(symptom)) {
      sum = map[symptom]!.values
          .map((pair) => pair[0])
          .reduce((value, element) => value + element);
    }
    return sum;
  }

  PriorityQueue<Pair<int, String>> firstScreen() {
    PriorityQueue<Pair<int, String>> topDiseases = PriorityQueue(
          (a, b) => b.first.compareTo(a.first),
    );

    for (var symptom in mpTemp.keys) {
      int probSum = probabilitySum(symptom, mpTemp);
      topDiseases.add(Pair(probSum, symptom));
    }
    return topDiseases;
  }

  PriorityQueue<Pair<int, String>> furtherScreen(
      String? input, Set<String> presentedSymptoms) {
    if (mpTemp.length == 1) {
      return endResult();
    }

    if (input != null && input != "No" && input != "None") {
      mpTemp.removeWhere((disease, symptoms) =>
      symptoms.containsKey(input) && symptoms[input]![0] > 0);
      mpTemp.values.forEach((symptoms) => symptoms.remove(input));
    } else if (input == "I have no symptom left") {
      return endResult();
    } else {
      mpTemp.removeWhere(
              (disease, symptoms) => symptoms.keys.toSet().containsAll(presentedSymptoms));
    }

    return firstScreen();
  }

  PriorityQueue<Pair<int, String>> endResult() {
    print("Selected Symptoms: $selectedSymptoms");

    PriorityQueue<Pair<int, String>> topDiseases = PriorityQueue(
          (a, b) => b.first.compareTo(a.first),
    );

    mpTemp.forEach((disease, symptoms) {
      int probSum = 0;
      for (var symptom in selectedSymptoms) {
        if (symptoms.containsKey(symptom)) {
          probSum += symptoms[symptom]![0];
        }
      }
      topDiseases.add(Pair(probSum, disease));
    });

    return topDiseases;
  }
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

void main() {
  String jsonData = '''
    // Paste the JSON data here
    {
  "Common Flu": {
    "symptoms": [
      {"name": "Fatigue", "probability": 2, "severity": 1},
      {"name": "Runny Nose", "probability": 3, "severity": 3},
      {"name": "Headache", "probability": 2, "severity": 2},
      {"name": "Bodyache", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 3, "severity": 2},
      {"name": "Coughing", "probability": 2, "severity": 2},
      {"name": "Sneezing", "probability": 3, "severity": 2},
      {"name": "Sore Throat", "probability": 2, "severity": 2}
    ]
  },
  "Gastritis": {
    "symptoms": [
      {"name": "Abdominal Pain", "probability": 3, "severity": 3},
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Burning in upper abdomen", "probability": 3, "severity": 3},
      {"name": "Indigestion", "probability": 2, "severity": 1}
    ]
  },
  "Gout": {
    "symptoms": [
      {"name": "Joint Swelling", "probability": 2, "severity": 2},
      {"name": "Joint pain in great toe", "probability": 3, "severity": 3},
      {"name": "Warmth in joint", "probability": 2, "severity": 2},
      {"name": "Skin redness", "probability": 1, "severity": 2},
      {"name": "Limited range of motion", "probability": 2, "severity": 2}
    ]
  },
  "Lung Abcess": {
    "symptoms": [
      {"name": "Fatigue", "probability": 1, "severity": 2},
      {"name": "Fever", "probability": 3, "severity": 3},
      {"name": "Coughing", "probability": 2, "severity": 2},
      {"name": "Chest Pain", "probability": 3, "severity": 3},
      {"name": "Shortness of breath", "probability": 2, "severity": 2},
      {"name": "Chills and Rigour", "probability": 3, "severity": 3}
    ]
  },
  "Peptic Ulcer disease": {
    "symptoms": [
      {"name": "Loss of Appetite", "probability": 1, "severity": 1},
      {"name": "Abdominal Pain", "probability": 3, "severity": 3},
      {"name": "Nausea", "probability": 2, "severity": 1},
      {"name": "Heart Burn", "probability": 3, "severity": 2},
      {"name": "Weight Loss", "probability": 1, "severity": 1},
      {"name": "Melena", "probability": 1, "severity": 3}
    ]
  },
  "Malaria": {
    "symptoms": [
      {"name": "Vomiting", "probability": 1, "severity": 1},
      {"name": "Headache", "probability": 1, "severity": 1},
      {"name": "Bodyache", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 3, "severity": 3},
      {"name": "Chills and Sweating", "probability": 3, "severity": 3}
    ]
  },
  "Tuberculosis": {
    "symptoms": [
      {"name": "Loss of Appetite", "probability": 2, "severity": 1},
      {"name": "Fatigue", "probability": 2, "severity": 1},
      {"name": "Fever", "probability": 3, "severity": 2},
      {"name": "Coughing", "probability": 3, "severity": 3},
      {"name": "Weight Loss", "probability": 3, "severity": 2},
      {"name": "Chest Pain", "probability": 1, "severity": 1},
      {"name": "Coughing up blood", "probability": 1, "severity": 1},
      {"name": "Shortness of breath", "probability": 2, "severity": 2}
    ]
  },
  "Food poisoning": {
    "symptoms": [
      {"name": "Abdominal Pain", "probability": 2, "severity": 2},
      {"name": "Fatigue", "probability": 2, "severity": 2},
      {"name": "Nausea", "probability": 3, "severity": 3},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Diarrhoea", "probability": 3, "severity": 3}
    ]
  },
  "Gastroenteritis": {
    "symptoms": [
      {"name": "Abdominal Pain", "probability": 2, "severity": 2},
      {"name": "Fatigue", "probability": 1, "severity": 1},
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 1, "severity": 1},
      {"name": "Loose Motion", "probability": 3, "severity": 3}
    ]
  },
  "Tension headache": {
    "symptoms": [
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Headache", "probability": 3, "severity": 3},
      {"name": "Pressure around head", "probability": 3, "severity": 3},
      {"name": "Difficulty in sleep", "probability": 3, "severity": 2}
    ]
  },
  "Drug Reaction": {
    "symptoms": [
      {"name": "Nausea", "probability": 1, "severity": 1},
      {"name": "Vomiting", "probability": 1, "severity": 1},
      {"name": "Itching", "probability": 3, "severity": 3},
      {"name": "Rash", "probability": 3, "severity": 2},
      {"name": "Dizziness", "probability": 1, "severity": 1}
    ]
  },
  "Dengue": {
    "symptoms": [
      {"name": "Abdominal Pain", "probability": 1, "severity": 3},
      {"name": "Fatigue", "probability": 2, "severity": 2},
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Headache", "probability": 2, "severity": 2},
      {"name": "Bodyache", "probability": 3, "severity": 3},
      {"name": "Fever", "probability": 3, "severity": 3},
      {"name": "Joint Pain", "probability": 3, "severity": 3},
      {"name": "Rash", "probability": 1, "severity": 2},
      {"name": "Melena", "probability": 1, "severity": 3},
      {"name": "Eye Pain", "probability": 2, "severity": 2},
      {"name": "Epistaxis", "probability": 1, "severity": 3}
    ]
  },
  "Typhoid": {
    "symptoms": [
      {"name": "Loss of Appetite", "probability": 2, "severity": 2},
      {"name": "Abdominal Pain", "probability": 1, "severity": 1},
      {"name": "Fatigue", "probability": 2, "severity": 1},
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Headache", "probability": 1, "severity": 1},
      {"name": "Bodyache", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 3, "severity": 3}
    ]
  },
  "COPD": {
    "symptoms": [
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Coughing", "probability": 2, "severity": 2},
      {"name": "Difficulty in breathing", "probability": 3, "severity": 3},
      {"name": "Wheezing sound", "probability": 1, "severity": 2}
    ]
  },
  "Bronchitis": {
    "symptoms": [
      {"name": "Fatigue", "probability": 2, "severity": 1},
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Coughing", "probability": 3, "severity": 3},
      {"name": "Shortness of breath", "probability": 2, "severity": 2},
      {"name": "Wheezing sound", "probability": 1, "severity": 2},
      {"name": "Chest Tightness", "probability": 1, "severity": 2}
    ]
  },
  "Cellulitis": {
    "symptoms": [
      {"name": "Fever", "probability": 3, "severity": 2},
      {"name": "Skin redness", "probability": 3, "severity": 2},
      {"name": "Pain and Tenderness in affected area", "probability": 3, "severity": 3},
      {"name": "Edema at affected area", "probability": 2, "severity": 2}
    ]
  },
  "Osteoarthritis": {
    "symptoms": [
      {"name": "Joint Pain", "probability": 3, "severity": 3},
      {"name": "Joint Swelling", "probability": 3, "severity": 2},
      {"name": "Stiffness", "probability": 2, "severity": 2},
      {"name": "Crepitus", "probability": 1, "severity": 1}
    ]
  },
  "Tonsilitis": {
    "symptoms": [
      {"name": "Headache", "probability": 1, "severity": 2},
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Sore Throat", "probability": 3, "severity": 3},
      {"name": "Difficulty in Swallowing", "probability": 3, "severity": 2},
      {"name": "Voice Changes", "probability": 2, "severity": 2},
      {"name": "Neck Pain", "probability": 2, "severity": 2}
    ]
  },
  "OCD": {
    "symptoms": [
      {"name": "Headache", "probability": 2, "severity": 2},
      {"name": "Difficulty in Concentrating", "probability": 3, "severity": 2},
      {"name": "Repeated doing same activity without any reason", "probability": 3, "severity": 3},
      {"name": "Anxiety", "probability": 3, "severity": 2}
    ]
  },
  "Haemorrhoids(Piles)": {
    "symptoms": [
      {"name": "Constipation", "probability": 3, "severity": 3},
      {"name": "Rectal bleeding", "probability": 3, "severity": 3},
      {"name": "Swelling around anus", "probability": 2, "severity": 2},
      {"name": "Itching in anal region", "probability": 2, "severity": 2},
      {"name": "Pain in rectal area", "probability": 1, "severity": 1},
      {"name": "Mucus discharge", "probability": 2, "severity": 1}
    ]
  },
  "Carpel tunnel syndrome": {
    "symptoms": [
      {"name": "Hand and Wrist Pain", "probability": 3, "severity": 3},
      {"name": "Radiating Pain", "probability": 3, "severity": 3},
      {"name": "Tingling numbness in little, ring, middle finger", "probability": 3, "severity": 2},
      {"name": "Muscle weakness", "probability": 2, "severity": 2}
    ]
  },
  "Sinusitis": {
    "symptoms": [
      {"name": "Headache", "probability": 2, "severity": 2},
      {"name": "Nasal Congestion", "probability": 3, "severity": 3},
      {"name": "Nasal Discharge", "probability": 3, "severity": 2},
      {"name": "Facial Pain", "probability": 2, "severity": 2},
      {"name": "Loss of Smell", "probability": 2, "severity": 2},
      {"name": "Bad Breath", "probability": 1, "severity": 1}
    ]
  },
  "Vertigo": {
    "symptoms": [
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Headache", "probability": 2, "severity": 2},
      {"name": "Dizziness", "probability": 2, "severity": 2},
      {"name": "Spinning Sensation", "probability": 3, "severity": 3},
      {"name": "Balance Problems", "probability": 3, "severity": 3}
    ]
  },
  "Rheumatoid Arthritis": {
    "symptoms": [
      {"name": "Joint Pain", "probability": 3, "severity": 3},
      {"name": "Joint Swelling", "probability": 3, "severity": 2},
      {"name": "Tenderness of Joint", "probability": 2, "severity": 2},
      {"name": "Joint Deformity", "probability": 1, "severity": 3},
      {"name": "Nodule", "probability": 1, "severity": 2},
      {"name": "Stiffness", "probability": 1, "severity": 2}
    ]
  },
  "Common Cold": {
    "symptoms": [
      {"name": "Runny Nose", "probability": 3, "severity": 2},
      {"name": "Headache", "probability": 1, "severity": 1},
      {"name": "Bodyache", "probability": 1, "severity": 1},
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Coughing", "probability": 2, "severity": 1},
      {"name": "Sneezing", "probability": 2, "severity": 2},
      {"name": "Sore Throat", "probability": 3, "severity": 3}
    ]
  },
  "Migraine": {
    "symptoms": [
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Headache", "probability": 3, "severity": 3},
      {"name": "Throbbing Pain", "probability": 3, "severity": 3},
      {"name": "Unilateral Pain", "probability": 3, "severity": 2},
      {"name": "Aura Symptoms", "probability": 2, "severity": 2},
      {"name": "Sensitivity to Light", "probability": 2, "severity": 1},
      {"name": "Sensitivity to Sound", "probability": 2, "severity": 1},
      {"name": "Irritated mood", "probability": 1, "severity": 3}
    ]
  },
  "Insomnia": {
    "symptoms": [
      {"name": "Irritated mood", "probability": 2, "severity": 2},
      {"name": "Difficulty in sleep", "probability": 3, "severity": 3},
      {"name": "Early Morning Awakening", "probability": 3, "severity": 3},
      {"name": "Daytime Sleepiness", "probability": 3, "severity": 2},
      {"name": "Difficulty in Concentrating", "probability": 2, "severity": 2}
    ]
  },
  "Pneumonia": {
    "symptoms": [
      {"name": "Fatigue", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 3, "severity": 3},
      {"name": "Coughing", "probability": 3, "severity": 3},
      {"name": "Chills and Sweating", "probability": 2, "severity": 2},
      {"name": "Chest Pain", "probability": 2, "severity": 2},
      {"name": "Difficulty in breathing", "probability": 2, "severity": 2},
      {"name": "Coughing up blood", "probability": 1, "severity": 1}
    ]
  },
  "Acid Reflux(GERD)": {
    "symptoms": [
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Heart Burn", "probability": 3, "severity": 3},
      {"name": "Chest Pain", "probability": 1, "severity": 2},
      {"name": "Difficulty in Swallowing", "probability": 2, "severity": 2},
      {"name": "Bloating", "probability": 2, "severity": 3}
    ]
  },
  "Pharyngitis": {
    "symptoms": [
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Coughing", "probability": 3, "severity": 3},
      {"name": "Sore Throat", "probability": 3, "severity": 3},
      {"name": "Difficulty in Swallowing", "probability": 2, "severity": 2},
      {"name": "Throat Pain", "probability": 3, "severity": 2},
      {"name": "Voice Changes", "probability": 2, "severity": 2}
    ]
  },
  "Chicken pox": {
    "symptoms": [
      {"name": "Fatigue", "probability": 1, "severity": 1},
      {"name": "Fever", "probability": 2, "severity": 2},
      {"name": "Itching", "probability": 3, "severity": 2},
      {"name": "Rash", "probability": 3, "severity": 3}
    ]
  },
  "Acute Gastroenteritis": {
    "symptoms": [
      {"name": "Abdominal Pain", "probability": 2, "severity": 1},
      {"name": "Nausea", "probability": 2, "severity": 2},
      {"name": "Vomiting", "probability": 2, "severity": 2},
      {"name": "Fever", "probability": 2, "severity": 1},
      {"name": "Loose Motion", "probability": 3, "severity": 3}
    ]
  },
  "Hepatitis": {
    "symptoms": [
      {"name": "Loss of Appetite", "probability": 3, "severity": 3},
      {"name": "Abdominal Pain", "probability": 1, "severity": 1},
      {"name": "Jaundice", "probability": 1, "severity": 2},
      {"name": "Fatigue", "probability": 2, "severity": 2},
      {"name": "Nausea", "probability": 3, "severity": 3},
      {"name": "Vomiting", "probability": 3, "severity": 3}
    ]
  },
  "Urinary Tract Infection": {
    "symptoms": [
      {"name": "Fever", "probability": 2, "severity": 3},
      {"name": "Burning sensation during urination", "probability": 3, "severity": 3},
      {"name": "Frequent Urination", "probability": 3, "severity": 3},
      {"name": "Pain in Lower Abdomen", "probability": 1, "severity": 2},
      {"name": "Foul-Smelling Urine", "probability": 1, "severity": 1},
      {"name": "Cloudy Urine", "probability": 1, "severity": 1},
      {"name": "Bloody Urine", "probability": 1, "severity": 1}
    ]
  },
  "Depression": {
    "symptoms": [
      {"name": "Loss of Appetite", "probability": 2, "severity": 2},
      {"name": "Fatigue", "probability": 2, "severity": 2},
      {"name": "Weight Loss", "probability": 2, "severity": 2},
      {"name": "Difficulty in sleep", "probability": 2, "severity": 2},
      {"name": "Difficulty in Concentrating", "probability": 3, "severity": 3},
      {"name": "Not feeling good", "probability": 3, "severity": 3}
    ]
  }
}

  ''';

  Map<String, dynamic> data = json.decode(jsonData);

  Map<String, Map<String, List<int>>> parsedData = {};

  data.forEach((disease, value) {
    List<String> symptoms = [];
    (value['symptoms'] as List).forEach((symptom) {
      symptoms.add(symptom['name']);
    });
    Map<String, List<int>> symptomMap = {};
    symptoms.forEach((symptom) {
      symptomMap[symptom] = [value['symptoms'][symptoms.indexOf(symptom)]['probability'], value['symptoms'][symptoms.indexOf(symptom)]['severity']];
    });
    parsedData[disease] = symptomMap;
  });

  SymptomSelector selector = SymptomSelector(parsedData);

  // print("First Screen:");
  print(selector.firstScreen());

  // Example usage of furtherScreen
  // print("\nFurther Screen:");
  // print(selector.furtherScreen("Fatigue", {'Runny Nose', 'Headache'}));
}
