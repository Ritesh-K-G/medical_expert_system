import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medical_expert_system/constants.dart';
import 'package:medical_expert_system/controller/descrptionController.dart';
import 'package:medical_expert_system/controller/diseaseController.dart';
import 'package:medical_expert_system/models/pair.dart';
import 'package:medical_expert_system/utils/styles/text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class showResult extends StatefulWidget {
  final String suggestions;
  final DiseaseController diseaseController;
  final descriptionController DescriptionController;
  showResult({required this.diseaseController, required this.DescriptionController, required this.suggestions});
  @override
  _showResult createState() => _showResult();
}

class _showResult extends State<showResult> {
  int _expandedIndex = -1;
  FlutterTts flutterTts = FlutterTts();
  List<String> mySelectedSymptoms = [];
  List<Pair<String, Pair<int, int>>> myPotentialDiseases = [];
  bool isEnglish = true;
  List<String> criticalTxt = [
    'Minor',
    'Needs Attention',
    'Severe'
  ];
  List<String> criticalHindiTxt = [
    'कम गंभीर',
    'ध्यान देने की ज़रूरत है',
    'गंभीर'
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    mySelectedSymptoms = widget.diseaseController.selectedSymptoms;
    myPotentialDiseases = widget.diseaseController.getPotentialDiseases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Back to Home', style: AppTextStyles.appBarText),
          actions: <Widget>[
            IconButton(
              icon: const Icon(IconData(0xf7a9, fontFamily: 'MaterialIcons'), size: 28),
              onPressed: () {
                setState(() {
                  isEnglish = !isEnglish;
                });
              },
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected symptoms:',
                    softWrap: true,
                    style: AppTextStyles.questionText,
                  ),
                  const SizedBox(height: 20),
                  if (mySelectedSymptoms.isEmpty)
                    const Text(
                      'No symptoms selected',
                      softWrap: true,
                      style: AppTextStyles.chanceText,
                    ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      mySelectedSymptoms.length,
                          (index) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.05),
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Text(
                            isEnglish
                              ? mySelectedSymptoms[index]
                              : widget.DescriptionController.diseases[mySelectedSymptoms[index]]!.hindiName,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Suggestions:',
                    softWrap: true,
                    style: AppTextStyles.questionText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Gemini Suggestions',
                      softWrap: true,
                      style: AppTextStyles.questionText
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'The predicted diseases according to your symptoms:',
                    softWrap: true,
                    style: AppTextStyles.questionText,
                  ),
                  const SizedBox(height: 20),
                  if (myPotentialDiseases.isEmpty)
                    const Text(
                      'You must select some symptoms to predict your disease',
                      softWrap: true,
                      style: AppTextStyles.chanceText,
                    ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: myPotentialDiseases.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.borderGrey,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 25),
                                            Expanded(
                                              child: Text(
                                                  isEnglish
                                                    ? myPotentialDiseases[index].first
                                                    : widget.DescriptionController.diseases[myPotentialDiseases[index].first]!.hindiName,
                                                  softWrap: true,
                                                  style: AppTextStyles.optionText
                                                      .copyWith(
                                                      color: Colors.black
                                                  )
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _expandedIndex = _expandedIndex == index ? -1 : index;
                                                });
                                              },
                                              icon: Icon(
                                                _expandedIndex == index ? Icons.expand_less : Icons.expand_more,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (_expandedIndex == index)
                                          Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(width: 33),
                                                      Text('${myPotentialDiseases[index].second.first}% chance', style: AppTextStyles.chanceText),
                                                      const SizedBox(width: 33),
                                                      Text(
                                                        isEnglish
                                                          ? criticalTxt[myPotentialDiseases[index].second.second - 1]
                                                          : criticalHindiTxt[myPotentialDiseases[index].second.second - 1]
                                                      , style: AppTextStyles.chanceText),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(width: 33),
                                                      Expanded(child: Text(
                                                          isEnglish
                                                              ? widget.DescriptionController.diseases[myPotentialDiseases[index].first]!.description
                                                              : widget.DescriptionController.diseases[myPotentialDiseases[index].first]!.hindiDescription,
                                                        softWrap: true,
                                                        style: AppTextStyles.descriptionText,
                                                      )),
                                                      IconButton(onPressed: () async {
                                                        if (isEnglish) {
                                                          await flutterTts.setLanguage("en-US");
                                                          flutterTts.speak(
                                                              widget.DescriptionController.diseases[myPotentialDiseases[index].first]!.description
                                                          );
                                                        }
                                                        else {
                                                          await flutterTts.setLanguage("hi-IN");
                                                          flutterTts.speak(
                                                              widget.DescriptionController.diseases[myPotentialDiseases[index].first]!.hindiDescription
                                                          );
                                                        }
                                                      }, icon: const Icon(Icons.volume_up_sharp))
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10)
                            ],
                          );
                        },
                      )
                  )
                ]
            )
        )
    );
  }
}