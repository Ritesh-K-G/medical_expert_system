import 'package:flutter/material.dart';
import 'package:medical_expert_system/constants.dart';
import 'package:medical_expert_system/controller/descrptionController.dart';
import 'package:medical_expert_system/controller/diseaseController.dart';
import 'package:medical_expert_system/utils/helpers/screen_size_helper.dart';
import 'package:medical_expert_system/utils/styles/button.dart';
import 'package:medical_expert_system/utils/styles/text.dart';
import 'package:medical_expert_system/views/result_screen/showResult.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:dio/dio.dart';

class question_screen extends StatefulWidget {
  final int age;
  final String gender;

  question_screen({required this.age, required this.gender});
  @override
  _question_screen createState() => _question_screen();
}

class _question_screen extends State<question_screen> {
  int _selectedIndex = -1;
  int _expandedIndex = -1;
  double _criticalLevl = 1.0;
  FlutterTts flutterTts = FlutterTts();
  late DiseaseController diseaseController;
  List<String> symptoms = [];
  descriptionController DescriptionController = descriptionController();
  bool isEnglish = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    diseaseController = DiseaseController();
    (()async =>{
      await diseaseController.loadDiseasesData()
          .then((value) async =>  await DescriptionController.loadDescription()
          .then((value) => getCurrentSymptoms())
          .then((value) => print('hello world')))
    })();
  }

  void getCurrentSymptoms() {
    symptoms = diseaseController.getSymptoms();
    if (symptoms.isEmpty) {
      terminate();
    }
    symptoms.add('None of These');
    symptoms.add('I have no other symptom');
    setState(() {
      _selectedIndex = -1;
      _expandedIndex = -1;
    });
  }

  void selectSymptom(String symptom) {
    if (symptom == 'I have no other symptom') {
      terminate();
    }
    diseaseController.setCritical(symptom, _criticalLevl.toInt());
    diseaseController.selectSymptom(symptom);
  }

  void deleteSymptom() {
    symptoms.removeLast();
    symptoms.removeLast();
    diseaseController.deleteSymptoms(symptoms);
  }

  void terminate() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Analyzing data...'),
            ],
          ),
        );
      },
    );
    String suggestions = 'Server error!!';
    final dio = Dio();
    try {
          var res = await dio.post(
            'https://medical-expert-system-backend-3.onrender.com/user',
            data: {
              'age': widget.age,
              'gender': widget.gender,
              'symptoms': diseaseController.mySelectedSymptoms()
          });
          String temp = res.data;
          suggestions = temp.replaceAll('*', '');
          print(suggestions);
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Bad Request!!'),
      ));
    }finally{
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => showResult(diseaseController: diseaseController, DescriptionController: DescriptionController, suggestions: suggestions))
      );
    }
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
                'Choose the symptom you are affected with:',
                softWrap: true,
                style: AppTextStyles.questionText,
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                    itemCount: symptoms.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedIndex == index ? AppColors.primary : AppColors.borderGrey,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = (_selectedIndex == index ? -1 : index);
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Icon(
                                            _selectedIndex == index ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                            color: _selectedIndex == index ? AppColors.primary : null,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                                isEnglish ?
                                                symptoms[index]
                                                : DescriptionController.diseases[symptoms[index]]!.hindiName,
                                                softWrap: true,
                                                style: AppTextStyles.optionText
                                                .copyWith(
                                                  color: _selectedIndex == index ? AppColors.primary : Colors.black
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
                                      if (_selectedIndex == index && _selectedIndex != (symptoms.length - 1) && _selectedIndex != (symptoms.length - 2))
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8.0),
                                            Text(
                                              'Severity level: $_criticalLevl',
                                              style: AppTextStyles.formLabelStyle,
                                            ),
                                            const SizedBox(height: 8.0),
                                            Slider(
                                              value: _criticalLevl,
                                              min: 1.0,
                                              max: 3.0,
                                              divisions: 2,
                                              onChanged: (value) {
                                                setState(() {
                                                  _criticalLevl = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      if (_expandedIndex == index)
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 33),
                                              Expanded(child:
                                              Text(
                                                isEnglish
                                                ? DescriptionController.diseases[symptoms[index]]!.description
                                                    : DescriptionController.diseases[symptoms[index]]!.hindiDescription
                                                ,
                                                softWrap: true,
                                                style: AppTextStyles.descriptionText,
                                              )),
                                              IconButton(onPressed: () async {
                                                if (isEnglish) {
                                                  await flutterTts.setLanguage("en-US");
                                                  flutterTts.speak(
                                                      DescriptionController.diseases[symptoms[index]]!.description
                                                  );
                                                }
                                                else {
                                                  await flutterTts.setLanguage("hi-IN");
                                                  flutterTts.speak(
                                                      DescriptionController.diseases[symptoms[index]]!.hindiDescription
                                                  );
                                                }
                                              }, icon: const Icon(Icons.volume_up_sharp))
                                            ],
                                          )
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      );
                    },
                  )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedIndex == (symptoms.length - 1)) {
                        terminate();
                      }
                      else if (_selectedIndex == (symptoms.length - 2)) {
                        deleteSymptom();
                        getCurrentSymptoms();
                      }
                      else {
                        selectSymptom(symptoms[_selectedIndex]);
                        getCurrentSymptoms();
                      }
                    },
                    style: AppButtonStyles.authButtons.copyWith(
                      minimumSize: MaterialStatePropertyAll(
                          Size(AppHelpers.screenWidth(context) * 0.8, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: AppTextStyles.buttontext,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}