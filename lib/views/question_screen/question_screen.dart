import 'package:flutter/material.dart';
import 'package:medical_expert_system/constants.dart';
import 'package:medical_expert_system/utils/helpers/screen_size_helper.dart';
import 'package:medical_expert_system/utils/styles/button.dart';
import 'package:medical_expert_system/utils/styles/text.dart';
// import 'package:text_to_speech/text_to_speech.dart';

class question_screen extends StatefulWidget {
  @override
  _question_screen createState() => _question_screen();
}

class _question_screen extends State<question_screen> {
  int _selectedIndex = -1;
  int _expandedIndex = -1;
  // TextToSpeech tts = TextToSpeech();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
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
                                                'Coughing',
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
                                      if (_expandedIndex == index)
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 33),
                                              Expanded(child: Text(
                                                'The temperature of the body is increased in this case',
                                                softWrap: true,
                                                style: AppTextStyles.descriptionText,
                                              )),
                                              IconButton(onPressed: () {
                                                // tts.speak('Good Morning');
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