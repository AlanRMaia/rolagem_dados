import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';

class Database extends GetxController {
  final Firestore _firestore = Firestore.instance;

  // bool _isLoading = false;

  // bool get isLoading => _isLoading;

  // void set isLoading(bool data) {
  //   _isLoading = data;
  // }

  final _messages = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get messages => _messages;

  //final _messages = <Map<String, dynamic>>[].obs;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection('users').document(user.id).setData(
          {'name': user.name, 'email': user.email, 'phone': user.phone});
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

  Future<void> loadAllMessages() async {
    _firestore
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((snapshot) {
      _messages.clear();

      for (final DocumentSnapshot message in snapshot.documents) {
        _messages.add(message.data);
      }
    });
  }

  void handleSubmitted({String text, File imgFile}) {
    if (UserController.to.user != null) {
      _sendMessage(text: text, user: UserController.to.user, imgFile: imgFile);
    }
  }

  Future<void> _sendMessage({String text, File imgFile, UserModel user}) async {
    try {
      if (imgFile != null) {
        final StorageUploadTask task = FirebaseStorage.instance
            .ref()
            .child(UserController.to.user.id +
                DateTime.now().millisecondsSinceEpoch.toString())
            .putFile(imgFile);

        final StorageTaskSnapshot taskSnapshot = await task.onComplete;
        final String url = await taskSnapshot.ref.getDownloadURL() as String;

        await _firestore.collection('messages').add({
          'imgUrl': url,
          'text': text,
          'senderName': user.name,
          'senderPhotoUrl': user.image,
          'uid': user.id,
          'time': Timestamp.now()
        });
      } else {
        await _firestore.collection('messages').add({
          'text': text,
          'imgUrl': imgFile,
          'senderName': user.name,
          'senderPhotoUrl': user.image,
          'uid': user.id,
          'time': Timestamp.now()
        });
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
