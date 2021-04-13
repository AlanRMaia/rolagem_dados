import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/services/data_base.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Database());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
