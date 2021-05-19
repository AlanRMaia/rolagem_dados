import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';
import 'package:rolagem_dados/services/data_base.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Database());
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
