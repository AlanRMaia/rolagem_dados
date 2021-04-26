import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';

class TextComposerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TextComposerController());
  }
}
