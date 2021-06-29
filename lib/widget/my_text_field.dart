import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.inputType,
    this.textColor,
    this.onChaged,
    this.voidCallback,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.isDarkMode,
    this.borderWdth = 1,
    this.borderColorFocus = Colors.white,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Color textColor;
  final Function(dynamic) onChaged;
  final VoidCallback voidCallback;
  final Icon suffixIcon;
  final Icon prefixIcon;
  final int maxLines;
  final bool isDarkMode;
  final Color borderColorFocus;
  final double borderWdth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        maxLines: maxLines,
        onChanged: onChaged,
        controller: controller,
        style: kBodyText.copyWith(color: textColor),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColorFocus,
              width: borderWdth,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
