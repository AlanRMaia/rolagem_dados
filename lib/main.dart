import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolagem_dados/controllers/bindings/auth_binding.dart';
import 'package:rolagem_dados/controllers/bindings/chatScreen_bindings.dart';
import 'package:rolagem_dados/screens/chat/chat_screen.dart';
import 'package:rolagem_dados/screens/login.dart';
import 'package:rolagem_dados/screens/signup.dart';

import 'constants.dart';
import 'utils/root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black, // cor da barra superior
  //   statusBarIconBrightness: Brightness.light, // ícones da barra superior
  // ));

  // Firestore.instance.collection('teste').add(
  //   {'teste': 'teste'},
  // ); //cria coleção(pasta) o add adiciona o map dentro do parênteses
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
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: kBackgroundColor,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: const IconThemeData(color: Colors.black)),
      home: Root(),
    );
  }
}
