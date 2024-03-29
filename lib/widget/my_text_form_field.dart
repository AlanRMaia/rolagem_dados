import 'package:flutter/material.dart';

import '../constants.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key key,
    this.controller,
    this.hintText,
    this.inputType,
    this.textColor,
    this.onChaged,
    this.voidCallback,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.isDarkMode,
    this.borderWdth = 1,
    this.borderColorFocus = Colors.white,
    this.validator,
    this.label,
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
  final String Function(String) validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        key: key,
        validator: validator,
        maxLines: maxLines,
        onChanged: onChaged,
        controller: controller,
        style: kBodyText.copyWith(color: textColor),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
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
