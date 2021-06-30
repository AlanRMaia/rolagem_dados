import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Colors
const kBackgroundColor = Color(0xff191720);
const kTextFieldFill = Color(0xff1E1C24);
// TextStyles
final kHeadline = TextStyle(
  color: Get.isDarkMode ? Colors.white : Colors.black87,
  fontSize: 34,
  fontWeight: FontWeight.bold,
);

const kBodyText = TextStyle(
  color: Colors.grey,
  fontSize: 15,
);

final kButtonText = TextStyle(
  color: Get.isDarkMode ? Colors.black87 : Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

final kBodyText2 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Get.isDarkMode ? Colors.white : Colors.black);
