import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';

class Database extends GetxController {
  final Firestore _firestore = Firestore.instance;
  //final _messages = <Map<String, dynamic>>[].obs;

  //List<Map<String, dynamic>> get messages => _messages;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .document(user.id)
          .setData({'name': user.name, 'email': user.email});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('users').document(uid).get();

      return UserModel.fromDocumentSnapsho(doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Future<void> loadMessages() async {
  //   _firestore.collection('messages').snapshots().listen((snapshot) {
  //     for (final DocumentSnapshot message in snapshot.documents) {
  //       _messages.add(message.data);
  //     }
  //   });
  // }

  void handleSubmitted(String text) {
    if (UserController.to.user != null) {
      _sendMessage(text: text, user: UserController.to.user);
    }
  }

  Future<void> _sendMessage(
      {String text, String imgUrl, UserModel user}) async {
    try {
      await _firestore.collection('messages').add({
        'text': text,
        'imgUrl': imgUrl,
        'senderName': user.name,
        'senderPhotoUrl': user.image
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
