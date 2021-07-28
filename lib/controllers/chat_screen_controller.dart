import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/services/data_base.dart';

class ChatScreenController extends GetxController
    with StateMixin<List<Map<String, dynamic>>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Database _database;

  ChatScreenController(this._database);

  @override
  void onInit() {
    loadMessages(Get.arguments as RoomModel);
    super.onInit();
  }

  final _isEmpty = false.obs;
  bool get isEmpty => _isEmpty.value;
  set isEmpty(bool value) {
    _isEmpty.value = value;
  }

  final _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  final _showSearch = false.obs;
  set showSearch(bool value) => _showSearch.value = value;
  bool get showSearch => _showSearch.value;

  final _userFriend = <UserModel>[].obs;
  List<UserModel> get userFriend => _userFriend;
  set userFriend(List<UserModel> value) => _userFriend.addAll(value);

  final Rx<RoomModel> _room = RoomModel().obs;
  RoomModel get room => _room.value;
  set room(RoomModel value) => _room.value = value;

  // Future<void> loadMessages() async {
  //   change([], status: RxStatus.loading());
  //   try {
  //     _database.loadAllMessages();
  //     change(_database.messages, status: RxStatus.success());
  //   } catch (e) {
  //     print(e);
  //     change([], status: RxStatus.error());
  //   }
  // }

  final _messages = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get messages {
    return _messages;
  }

  Future<void> loadRoom(String idRoom) async {
    final data = RoomModel.fromMap(await _database.loadRoom(idRoom));
    room = data;
  }

  Future<void> loadMessages(RoomModel room) async {
    _firestore
        .collection('rooms')
        .doc(room.id)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((snapshot) {
      _messages.clear();
      change([], status: RxStatus.loading());

      for (final DocumentSnapshot message in snapshot.docs) {
        _messages.add(message.data());
      }
      change(_messages, status: RxStatus.success());
    });
  }

  Future<void> loadFriends(String email) async {
    try {
      final data = await _database.loadFriends(email: email);
      userFriend.addAll(data.map((map) => UserModel.fromMap(map)));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addFriendRoom(UserModel friend, String roomId) async {
    try {
      _database.addFriendRoom(friend, roomId);
    } catch (e) {
      rethrow;
    }
  }
}
