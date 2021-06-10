import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/services/data_base.dart';

class AddFriendController extends GetxController
    with StateMixin<List<Map<String, dynamic>>> {
  static AddFriendController get to => Get.find();
  final Database _database = Get.put(Database());

  final _isEmpty = false.obs;

  bool get isEmpty => _isEmpty.value;

  set isEmpty(bool value) {
    _isEmpty.value = value;
  }

  final _resultFriends = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get resultFriends {
    return _resultFriends;
  }

  set resultFriends(List<Map<String, dynamic>> value) =>
      _resultFriends.addAll(value);

  Future<void> loadFriends() async {
    change([], status: RxStatus.loading());
    try {
      final data =
          await _database.loadFriends(userId: UserController.to.user.id);
      change(data, status: RxStatus.success());
    } catch (e) {
      print(e);
      change([], status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> allResultsFriends(String name) async {
    try {
      resultFriends = await _database?.resultFriends(name);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addFriend(Map<String, dynamic> friendUser) async {
    try {
      await _database.addFriendSubmited(friendUser);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
