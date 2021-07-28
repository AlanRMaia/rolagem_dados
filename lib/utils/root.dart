import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/screens/bottom_bar_pages.dart';
import 'package:rolagem_dados/screens/presentation.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash:
            'assets/images/tumblr_e9bf36f6c796b1719f92174087a1243e_9dac765e_400.gif',
        backgroundColor: Colors.black54,
        splashIconSize: 100,
        nextScreen:
            controller.user?.uid != null ? BottomBarPages() : Presentation());
  }
}

// GetX(
//           initState: (_) async {
//             Get.put<UserController>(UserController());
//           },
//           builder: (_) {
//             if (controller.user?.uid != null) {
//               return BottomBarPages();
//             } else {
//               return Presentation();
//             }
//           },
//         )