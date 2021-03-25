import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:rolagem_dados/services/data_base.dart';

class ChatScreenController extends GetxController
    with StateMixin<List<Map<String, dynamic>>> {
  final Firestore _firestore = Firestore.instance;
  final Database _database;

  ChatScreenController(this._database);
  // ChatScreenController() {
  //   loadMessages();
  // }

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

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

  Future<void> loadMessages() async {
    _firestore
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
}
