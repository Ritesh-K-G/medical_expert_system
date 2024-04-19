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

  static const TextStyle dropdownText = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Hind',
  );
}
