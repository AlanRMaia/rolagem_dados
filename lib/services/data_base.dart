import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/firebase_file.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';

class Database extends GetxController {
  final Firestore _firestore = Firestore.instance;

  static Database get to => Get.find();

  // final _imgUrl = ''.obs;

  // String get imgUrl => _imgUrl.value;
  // set imgUrl(String value) {
  //   _imgUrl.value = value;
  // }

  final _messages = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get messages => _messages;

  final _rooms = <Map<String, dynamic>>[].obs;

  List<RoomModel> get rooms =>
      _rooms.map((value) => RoomModel.fromMap(value)).toList();

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .document(user.id)
          .setData(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('users').document(uid).get();

      return UserModel.fromDocumentSnapsho(doc);
    } catch (e) {
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

  void handleSubmitted({
    String text,
    File imgFile,
    RoomModel room,
    FirebaseFile file,
    UserModel user,
    String type,
  }) {
    _sendMessage(
      text: text,
      user: user,
      imgFile: imgFile,
      room: room,
      file: file,
      type: type,
    );
  }

  void roomCreateSubmitted({String name, File imgFile}) {
    if (UserController.to.user != null) {
      _createdRoom(name: name, user: UserController.to.user, imgFile: imgFile);
    }
  }

  void addUserRoomSubmitted(String idRoom) {
    _addUserRoom(idRoom);
  }

  Future<String> _imageRoom(File imgFile) async {
    try {
      final StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child('imageRooms')
          .child(basename(imgFile.path))
          .putFile(imgFile);

      final StorageTaskSnapshot taskSnapshot = await task.onComplete;
      final String url = await taskSnapshot.ref.getDownloadURL() as String;
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> imageUser(File imgFile) async {
    try {
      final StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child('imageUsers')
          .child(basename(imgFile.path))
          .putFile(imgFile);

      final StorageTaskSnapshot taskSnapshot = await task.onComplete;
      final String url = await taskSnapshot.ref.getDownloadURL() as String;
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _addUserRoom(String idRoom) async {
    try {} catch (e) {}
  }

  Future<void> _createdRoom({String name, UserModel user, File imgFile}) async {
    try {
      final doc = await _firestore.collection('rooms').add({
        'imgUrl': await _imageRoom(imgFile),
        'name': name,
        'admUserId': user.id,
      });
      final id = doc.documentID;

      await _firestore.collection('rooms').document(id).updateData({'id': id});

      await _firestore
          .collection('users')
          .document(user.id)
          .collection('rooms')
          .add({'id': id});
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> loadRoom(String idRoom) async {
    try {
      Map<String, dynamic> _room = {};
      Firestore.instance
          .collection('rooms')
          .document(idRoom)
          .snapshots()
          .listen((doc) {
        _room = doc.data;
      });

      return _room;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RoomModel>> loadRooms(String userId) async {
    try {
      final QuerySnapshot userRooms = await _firestore
          .collection('users')
          .document(userId)
          .collection('rooms')
          .getDocuments();

      final List<Map<String, dynamic>> allRooms = [];

      for (final DocumentSnapshot room in userRooms.documents) {
        final DocumentSnapshot roomDoc = await _firestore
            .collection('rooms')
            .document(room.data['id'].toString())
            .get();

        allRooms.add(roomDoc.data);
      }

      return allRooms.map((map) => RoomModel.fromMap(map)).toList();
    } catch (e) {
      rethrow;
    }
  }

  StorageUploadTask storageUpload(File file) {
    try {
      return FirebaseStorage.instance
          .ref()
          .child('/filesMessages')
          .child(basename(file.path))
          .putFile(file);
    } catch (e) {
      rethrow;
    }
  }

  StorageUploadTask storageUploadBytes(File file, Uint8List data) {
    try {
      return FirebaseStorage.instance
          .ref()
          .child('/filesMessages')
          .child(basename(file.path))
          .putData(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> storageDownloadUrl(StorageUploadTask task) async {
    try {
      final StorageTaskSnapshot taskSnapshot = await task.onComplete;
      return await taskSnapshot.ref.getDownloadURL() as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _sendMessage({
    String text,
    File imgFile,
    UserModel user,
    RoomModel room,
    FirebaseFile file,
    String type,
  }) async {
    try {
      if (imgFile != null) {
        final message = await _firestore
            .collection('rooms')
            .document(room.id)
            .collection('messages')
            .add({
          'fileUrl': file.url,
          'fileName': file.name,
          'fileBytes': file.byteTotal,
          'text': text,
          'senderName': user.name,
          'senderPhotoUrl': user.image,
          'uid': user.id,
          'idRoom': room.id,
          'time': Timestamp.now(),
          'type': type,
        });

        final id = message.documentID;

        await _firestore
            .collection('rooms')
            .document(room.id)
            .collection('messages')
            .document(id)
            .updateData({'id': id});
      } else {
        final message = await _firestore
            .collection('rooms')
            .document(room.id)
            .collection('messages')
            .add({
          'text': text,
          'fileUrl': imgFile,
          'senderName': user.name,
          'senderPhotoUrl': user.image,
          'uid': user.id,
          'idRoom': room.id,
          'time': Timestamp.now()
        });

        final id = message.documentID;

        await _firestore
            .collection('rooms')
            .document(room.id)
            .collection('messages')
            .document(id)
            .updateData({'id': id});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editSubmitted(
      String idMessage, String message, String idRoom) async {
    if (UserController.to.user != null) {
      _editMessage(idMessage, message, idRoom);
    }
  }

  Future<void> _editMessage(
      String idMessage, String message, String idRoom) async {
    try {
      await _firestore
          .collection('rooms')
          .document(idRoom)
          .collection('messages')
          .document(idMessage)
          .updateData({'text': message});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSubmited(String idMessage, String idRoom) async {
    if (UserController.to.user != null) {
      _deleteMessage(idMessage, idRoom);
    }
  }

  Future<void> _deleteMessage(String idMessage, String idRoom) async {
    try {
      await _firestore
          .collection('rooms')
          .document(idRoom)
          .collection('messages')
          .document(idMessage)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> loadFriends(
      {String name, String userId}) async {
    try {
      final QuerySnapshot userFriends = await _firestore
          .collection('users')
          .document(UserController.to.user.id)
          .collection('friends')
          .getDocuments();

      final List<Map<String, dynamic>> allFriends = [];

      if (name != null) {
        for (final DocumentSnapshot friendDoc in userFriends.documents) {
          if (friendDoc.data['name'] == name) {
            allFriends.add(friendDoc.data);
          }
        }

        return allFriends;
      } else {
        return userFriends.documents.map((e) => e.data).toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFriendSubmited(Map<String, dynamic> friendUser) async {
    if (UserController.to.user != null) {
      _addFriend(UserController.to.user.id, friendUser);
    }
  }

  Future<void> _addFriend(
      String userId, Map<String, dynamic> friendUser) async {
    try {
      _firestore
          .collection('users')
          .document(userId)
          .collection('friends')
          .add(friendUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> resultFriends(String name) async {
    try {
      final QuerySnapshot userFriends =
          await _firestore.collection('users').getDocuments();

      final List<Map<String, dynamic>> allFriends = [];

      for (final DocumentSnapshot friendDoc in userFriends.documents) {
        if (friendDoc.data['name'] == name) {
          allFriends.add(friendDoc?.data);
        }
      }

      return allFriends;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> userFriends(String name) async {
    try {
      final QuerySnapshot userFriends = await _firestore
          .collection('users')
          .document(UserController.to.user.id)
          .collection('friends')
          .getDocuments();

      final List<Map<String, dynamic>> allFriends = [];

      for (final DocumentSnapshot friendDoc in userFriends.documents) {
        if (friendDoc.data['name'] == name) {
          allFriends.add(friendDoc?.data);
        }
      }
      return allFriends;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFriendRoom(String userId, String roomId) async {
    try {
      _firestore
          .collection('users')
          .document(userId)
          .collection('rooms')
          .add({'id': roomId});
    } catch (e) {
      rethrow;
    }
  }
}
