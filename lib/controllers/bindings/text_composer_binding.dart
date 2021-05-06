import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/services/data_base.dart';

class TextComposerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Database());
    Get.lazyPut(() => TextComposerController(Get.find()));
  }
}
