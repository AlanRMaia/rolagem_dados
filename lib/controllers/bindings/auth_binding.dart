
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
  
}