import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/bottom_bar_pages_controller.dart';

class BottomBarPagesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarPagesController>(() => BottomBarPagesController());
  }
}
