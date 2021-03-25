import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/chat_screen_controller.dart';
import 'package:rolagem_dados/services/data_base.dart';

class ChatScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Database());
    Get.lazyPut(() => ChatScreenController(Get.find()));
  }
}
