import 'package:flutter/material.dart';

import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import '../constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key key,
    this.buttonName,
    this.onTap,
    this.bgColor,
    this.textColor,
    this.isLoading = false,
  }) : super(key: key);

  final String buttonName;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: isLoading == false
            ? TextButton(
                onPressed: onTap,
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.black12,
                  ),
                ),
                child: Text(
                  buttonName,
                  style: kButtonText.copyWith(color: textColor),
                ),
              )
            : Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Loading(
                    indicator: BallSpinFadeLoaderIndicator(),
                    color: Colors.black87,
                    size: 40,
                  ),
                ),
              ));
  }
}
