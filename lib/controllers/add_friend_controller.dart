import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/services/data_base.dart';

class AddFriendController extends GetxController
    with StateMixin<List<UserModel>> {
  static AddFriendController get to => Get.find();
  final Database _database = Get.put(Database());

  final _isEmpty = false.obs;

  bool get isEmpty => _isEmpty.value;

  set isEmpty(bool value) {
    _isEmpty.value = value;
  }

  final _resultFriends = <UserModel>[].obs;

  List<UserModel> get resultFriends {
    return _resultFriends;
  }

  set resultFriends(List<UserModel> value) => _resultFriends.addAll(value);

  Future<void> loadFriends() async {
    change([], status: RxStatus.loading());
    try {
      final data =
          await _database.loadFriends(userId: UserController.to.user.id);

      final user = data.map((map) => UserModel.fromMap(map)).toList();
      change(user, status: RxStatus.success());
    } catch (e) {
      print(e);
      change([], status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> resultsFriends(String email) async {
    try {
      final data = await _database?.searchUsersEmail(email);
      resultFriends = data.map((map) => UserModel.fromMap(map)).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addFriend(UserModel friendUser) async {
    try {
      await _database.addFriendSubmited(friendUser);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteFriend(UserModel user, UserModel friend) async {
    try {
      await _database.deleteFriend(user, friend.id);
    } catch (e) {
      rethrow;
    }
  }
}
