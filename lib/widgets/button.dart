import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/text_style.dart';

class ButtonElevated extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color backgroundColor, textColor;
  final bool isLoading;

  const ButtonElevated({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.isLoading,
    this.textColor = Colors.white,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
          textStyle: TextStyles.buttonText),
      onPressed: () {
        return isLoading ? null : press();
      },
      label: Text(text),
      icon: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Container(),
    );
  }
}
