import 'package:flutter/material.dart';
import 'package:medical_expert_system/utils/helpers/screen_size_helper.dart';
import 'package:medical_expert_system/utils/styles/button.dart';
import 'package:medical_expert_system/utils/styles/text.dart';
import 'package:medical_expert_system/utils/validators/validators.dart';
import 'package:medical_expert_system/utils/wrappers/wrappers.dart';
import 'package:medical_expert_system/views/splash_screen.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final TextEditingController _ageController = TextEditingController();
  String selectedGenderValue = "Male";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.20),
            Stack(children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFfffce3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        scale: 0.5,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/iiita-logo.png',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
            const SizedBox(height: 30),
            Text(
                'Medical Expert System',
                style: AppTextStyles.appHeader.copyWith(
                    color: Colors.black
                )
            ),
            const SizedBox(height: 30),
            Padding(padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Specify Your Gender',
                    style: AppTextStyles.formLabelStyle,
                  ),
                  AppWrappers.dropdownWrapper(
                    items: [
                      const DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male',
                            style: AppTextStyles.dropdownText),
                      ),
                      const DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female',
                            style: AppTextStyles.dropdownText),
                      )
                    ],
                    value: selectedGenderValue,
                    onChanged: (value) {
                      setState(() {
                        selectedGenderValue = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter Your Age',
                    style: AppTextStyles.formLabelStyle,
                  ),
                  AppWrappers.inputFieldWrapper(TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                        hintText: "Enter Your Age", border: InputBorder.none, errorMaxLines: 2),
                    style: AppTextStyles.formInputTextStyle,
                    keyboardType: TextInputType.number,
                    validator: AppValidators.validatePrice,
                  )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_ageController.text != '') {
                            _showUserAgreementDialog(context);
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
                          "Continue",
                          style: AppTextStyles.buttontext,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void _showUserAgreementDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top: 16.0),
                  child: Text(
                    'User Agreement',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Column(
                    children: [
                      const Text(
                          'Thank you for using our platform for diagnosing your disease. '
                              'We\'re committed to advancing research in healthcare, '
                              'and your contribution plays a crucial role in our efforts. '
                              'By agreeing to this user agreement, '
                              'you allow us to store your symptom data for research purposes. '
                              'We assure you that we prioritize your privacy and adhere to strict data protection measures.'
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFC62020),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(2.0),
                                child: const Text(
                                  'Decline',
                                  style: TextStyle(
                                      color: Color(0xFFFDFDFD),
                                      fontFamily: 'Hind',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => splashScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF13C39C),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(2.0),
                                child: const Text(
                                  'Accept',
                                  style: TextStyle(
                                    color: Color(0xFFFDFDFD),
                                    fontFamily: 'Hind',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8)
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
