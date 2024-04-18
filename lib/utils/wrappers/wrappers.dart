import 'package:flutter/material.dart';
import 'package:medical_expert_system/constants.dart';
import 'package:medical_expert_system/utils/styles/text.dart';

class AppWrappers {
  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static Widget inputFieldWrapper(Widget child) => Container(
    padding: const EdgeInsets.all(15.0),
    decoration: const BoxDecoration(
        color: AppColors.myTextBoxGray,
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child: child,
  );

  static Widget dropdownWrapper({
    List<DropdownMenuItem<dynamic>>? items,
    dynamic value,
    Function(dynamic)? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: AppColors.myTextBoxGray,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: DropdownButton(
        items: items,
        value: value,
        onChanged: onChanged,
        underline: Container(),
        style: AppTextStyles.authHeader,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        isExpanded: true,
      ),
    );
  }
}
