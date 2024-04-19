import 'package:flutter/material.dart';
import 'package:medical_expert_system/utils/styles/text.dart';
import 'package:medical_expert_system/utils/validators/validators.dart';
import 'package:medical_expert_system/utils/wrappers/wrappers.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
