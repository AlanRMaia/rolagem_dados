import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/add_friend_controller.dart';

class AddFriendControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFriendController>(() => AddFriendController());
  }
}
