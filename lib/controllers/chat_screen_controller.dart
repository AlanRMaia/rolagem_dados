import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  //final Database _database = Get.put(Database());
  final Firestore _firestore = Firestore.instance;
  ChatScreenController() {
    loadMessages();
  }

  final _messages = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get messages => _messages;

  Future<void> loadMessages() async {
    _firestore.collection('messages').snapshots().listen((snapshot) {
      _messages.clear();

      for (final DocumentSnapshot message in snapshot.documents) {
        _messages.add(message.data);
      }
    });
  }
}
