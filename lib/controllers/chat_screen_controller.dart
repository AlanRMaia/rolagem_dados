import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';

import 'package:rolagem_dados/services/data_base.dart';

import 'user_controller.dart';

class ChatScreenController extends GetxController
    with StateMixin<List<Map<String, dynamic>>> {
  final Firestore _firestore = Firestore.instance;
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
        .document(room.id)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((snapshot) {
      _messages.clear();

      for (final DocumentSnapshot message in snapshot.documents) {
        _messages.add(message.data);
      }
      change([], status: RxStatus.loading());
      change(_messages, status: RxStatus.success());
    });
  }

  Future<void> loadFriends(String name) async {
    try {
      final data = await _database.loadFriends(name: name);
      userFriend.addAll(data.map((map) => UserModel.fromMap(map)));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addFriendRoom(String userId, String roomId) async {
    try {
      _database.addFriendRoom(userId, roomId);
    } catch (e) {
      rethrow;
    }
  }
}
