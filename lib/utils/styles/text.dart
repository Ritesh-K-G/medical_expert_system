import 'package:flutter/material.dart';
import 'package:medical_expert_system/constants.dart';

class AppTextStyles {
  static const TextStyle appHeader = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.white
  );

  static const TextStyle formLabelStyle = TextStyle(
    color: AppColors.myCommentGray,
    fontFamily: 'Karla',
    fontSize: 14
  );

  static const TextStyle formInputTextStyle = TextStyle(
    fontFamily: 'Hind',
    fontSize: 16
  );

  static const TextStyle appBarText = TextStyle(
      fontFamily: 'Overpass',
      fontWeight: FontWeight.bold,
      fontSize: 16
  );

  static const TextStyle dropdownText = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Hind',
  );

  static const TextStyle buttontext = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
  );

  static TextStyle questionText = TextStyle(
    fontSize: 16,
    fontFamily: 'Overpass',
    color: const Color(0xFF090F47).withOpacity(0.75),
  );

  static const TextStyle optionText = TextStyle(
    fontSize: 16,
    fontFamily: 'Overpass',
    fontWeight: FontWeight.bold
  );

  static const TextStyle chanceText = TextStyle(
      fontSize: 16,
      fontFamily: 'Overpass',
      fontWeight: FontWeight.w500
  );

  static TextStyle descriptionText = TextStyle(
      fontSize: 16,
      fontFamily: 'Overpass',
      color: const Color(0xFF090F47).withOpacity(0.45)
  );
}
