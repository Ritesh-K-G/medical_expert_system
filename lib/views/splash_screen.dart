import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_expert_system/controller/diseaseController.dart';
import 'package:medical_expert_system/utils/styles/text.dart';
import 'package:medical_expert_system/views/homePage/homePage.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const homePage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.cover,
          ),
          Column(
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
              const Text(
                'Medical Expert System',
                style: AppTextStyles.appHeader
              )
            ],
          )
        ],
      ),
    );
  }
}
