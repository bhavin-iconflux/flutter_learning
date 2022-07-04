import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String label;
  final bool obscureText;
  final bool isEnabled;
  final TextEditingController controller;

  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.label,
      required this.controller,
      this.isEnabled = true,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyles.textFieldHintStyle,
      enabled: isEnabled,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyles.textFieldLabelStyle,
        hintStyle: TextStyles.textFieldHintStyle,
        labelText: label,
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      controller: controller,
    );
  }
}
