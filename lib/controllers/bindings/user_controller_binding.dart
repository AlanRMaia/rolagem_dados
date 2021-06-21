import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';

class UserControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }
}
