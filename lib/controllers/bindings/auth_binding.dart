import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
    Get.lazyPut<AuthController>(() => AuthController());
    // Get.put(Firebase.initializeApp());
  }
}
