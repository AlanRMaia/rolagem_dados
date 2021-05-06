import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/bottom_bar_pages.dart';
import 'package:rolagem_dados/screens/home.dart';
import 'package:rolagem_dados/screens/presentation.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (controller.user?.uid != null) {
          return BottomBarPages();
        } else {
          return Presentation();
        }
      },
    );
  }
}
