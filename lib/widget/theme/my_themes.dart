import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

mixin MyThemes {
  static final primary = Colors.blue;
  static final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
    // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(Get.context).textTheme),
    scaffoldBackgroundColor: kBackgroundColor,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark(),
    dividerColor: Colors.white,
    primaryColorDark: primaryColor,
  );

  static final lightTheme = ThemeData(
    // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(BuildContext context).textTheme),

    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(),
    dividerColor: Colors.black,
  );
}
