import 'package:flutter/material.dart';
import '../constants.dart';

class MyPasswordField extends StatelessWidget {
  MyPasswordField({
    Key key,
    this.controller,
    this.onChanged,
    this.showPassword,
    this.changeShowPassword,
    this.maxLines = 1,
    this.isDarkMode = true,
    this.borderColorFocus = Colors.white,
    this.borderWdth = 1,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  bool showPassword;
  VoidCallback changeShowPassword;
  final int maxLines;
  final bool isDarkMode;
  final Color borderColorFocus;
  final double borderWdth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: kBodyText.copyWith(
          color: Colors.white,
        ),
        controller: controller,
        obscureText: !showPassword,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: changeShowPassword,
              icon: Icon(
                !showPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: 'Password',
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
