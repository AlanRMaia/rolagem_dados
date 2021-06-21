import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/widget/theme/my_themes.dart';

Widget buildAppBar(VoidCallback func) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {
          Get.changeTheme(
              Get.isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme);
          func;
        },
        icon: Get.isDarkMode
            ? const Icon(Icons.light_mode_outlined)
            : const Icon(
                Icons.dark_mode_outlined,
              ),
      )
    ],
  );
}
