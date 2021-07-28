import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/bindings/auth_binding.dart';
import 'package:rolagem_dados/controllers/bindings/chatScreen_bindings.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/bottom_bar_pages.dart';
import 'package:rolagem_dados/screens/chat/chat_screen.dart';
import 'package:rolagem_dados/screens/login.dart';
import 'package:rolagem_dados/screens/signup.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/theme/my_themes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants/firebase.dart';
import 'utils/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );

  await initialization.then((value) async {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(HomeController(Database()));
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      getPages: [
        GetPage(
          name: '/chatscreen',
          page: () => ChatScreen(),
          binding: ChatScreenBindings(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUp(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => Login(),
          binding: AuthBinding(),
        ),
      ],
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Root(),
    );
  }
}
