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

  Future<void> editUser(UserModel user, File imgFile) async {
    try {
      String imgUrlStorage;

      if (imgFile != null) {
        imgUrlStorage = await imageUser(
            imgFile: imgFile, imgUrl: UserController.to.user.image);
      }
      _firestore.collection('users').document(user.id).updateData({
        'name': user.name,
        'email': user.email,
        'about': user.about,
        'image': imgUrlStorage ?? user.image
      });
    } catch (e) {
      rethrow;
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

  Future<void> changeDarkMode({bool darkMode, String uid}) async {
    try {
      _firestore
          .collection('users')
          .document(uid ?? UserController.to.user.id)
          .updateData({'isDarkMode': darkMode});
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

  Future<String> imageUser({File imgFile, String imgUrl}) async {
    try {
      // final imgStorageDelete = UserController.to.user?.image;

      // if (imgUrl != imgStorageDelete) {
      //   await FirebaseStorage.instance.ref().child(imgStorageDelete).delete();
      // }

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
        'admin': UserController.to.user.toMap(),
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
            .document(room?.id)
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
      {String idMessage, String message, String idRoom, int recomend}) async {
    if (UserController.to.user != null) {
      _editMessage(
          idMessage: idMessage,
          message: message,
          idRoom: idRoom,
          recomend: recomend);
    }
  }

  Future<void> _editMessage(
      {String idMessage, String message, String idRoom, int recomend}) async {
    try {
      await _firestore
          .collection('rooms')
          .document(idRoom)
          .collection('messages')
          .document(idMessage)
          .updateData(
              message != null ? {'text': message} : {'recomend': recomend});
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
      {String email, String userId}) async {
    try {
      final QuerySnapshot userFriends = await _firestore
          .collection('users')
          .document(UserController.to.user.id)
          .collection('friends')
          .getDocuments();

      final List<Map<String, dynamic>> allFriends = [];

      if (email != null) {
        final QuerySnapshot _users =
            await _firestore.collection('users').getDocuments();

        final List<Map<String, dynamic>> allUsers = [];

        for (final user in _users.documents) {
          if (user.data['email'] == email) {
            allUsers.add(user.data);
          }
        }

        return allUsers;
      } else {
        for (final DocumentSnapshot friendId in userFriends.documents) {
          final DocumentSnapshot friendDoc = await _firestore
              .collection('users')
              .document(friendId.data['id'].toString())
              .get();

          allFriends.add(friendDoc.data);
        }
        return allFriends;
      }

      // if (name != null) {
      //   for (final DocumentSnapshot friendDoc in userFriends.documents) {
      //     if (friendDoc.data['name'] == name) {
      //       allFriends.add(friendDoc.data);
      //     }
      //   }

      //   return allFriends;
      // } else {
      //   return userFriends.documents.map((e) => e.data).toList();
      // }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> numberOfRooms() async {
    try {
      final List<Map<String, dynamic>> _rooms = [];

      final doc = await Firestore.instance
          .collection('users')
          .document(UserController.to.user.id)
          .collection('rooms')
          .getDocuments();

      for (final room in doc.documents) {
        _rooms.add(room.data);
      }

      return _rooms.length;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> numberOfRoomsFriend(UserModel user) async {
    try {
      final List<Map<String, dynamic>> _rooms = [];

      final doc = await Firestore.instance
          .collection('users')
          .document(user.id)
          .collection('rooms')
          .getDocuments();

      for (final room in doc.documents) {
        _rooms.add(room.data);
      }

      return _rooms.length;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> numberOfFriends() async {
    try {
      final List<Map<String, dynamic>> _friends = [];
      final doc = await Firestore.instance
          .collection('users')
          .document(UserController.to.user.id)
          .collection('friends')
          .getDocuments();

      for (final friend in doc.documents) {
        _friends.add(friend.data);
      }

      return _friends.length;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> numberOfFriendsFriend(UserModel user) async {
    try {
      final List<Map<String, dynamic>> _friends = [];
      final doc = await Firestore.instance
          .collection('users')
          .document(user.id)
          .collection('friends')
          .getDocuments();

      for (final friend in doc.documents) {
        _friends.add(friend.data);
      }

      return _friends.length;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addFriendSubmited(UserModel friendUser) async {
    if (UserController.to.user != null) {
      _addFriend(UserController.to.user.id, friendUser);
    }
  }

  Future<void> _addFriend(String userId, UserModel friendUser) async {
    try {
      final userFriend = await _firestore
          .collection('users')
          .document(UserController.to.user.id)
          .collection('friends')
          .getDocuments();

      for (final friend in userFriend.documents) {
        if (friend.data['email'] == friendUser.email) {
          return Get.snackbar(friendUser.name, 'Esse usuário já é seu amigo',
              snackPosition: SnackPosition.BOTTOM);
        }
      }

      _firestore
          .collection('users')
          .document(userId)
          .collection('friends')
          .add(friendUser.toMap());
      Get.snackbar(friendUser.name, 'Foi adicionado como amigo',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFriend(UserModel user, String friendId) async {
    try {
      final friendsDocs = await _firestore
          .collection('users')
          .document(user.id)
          .collection('friends')
          .getDocuments();

      for (final friendDoc in friendsDocs.documents) {
        if (friendDoc.data['id'] == friendId) {
          await _firestore
              .collection('users')
              .document(user.id)
              .collection('friends')
              .document(friendDoc.documentID)
              .delete();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserRoom(RoomModel room, String userId) async {
    try {
      final usersDocs = await _firestore
          .collection('rooms')
          .document(room.id)
          .collection('users')
          .getDocuments();

      for (final userDoc in usersDocs.documents) {
        if (userDoc.data['id'] == userId) {
          await _firestore
              .collection('rooms')
              .document(room.id)
              .collection('users')
              .document(userDoc.documentID)
              .delete();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsersEmail(String email) async {
    try {
      if (email != null) {
        final QuerySnapshot _users =
            await _firestore.collection('users').getDocuments();

        final List<Map<String, dynamic>> allUsers = [];

        for (var user in _users.documents) {
          if (user.data['email'] == email) {
            allUsers.add(user.data);
          }
        }

        return allUsers;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> userFriends(String email) async {
    try {
      final QuerySnapshot userFriends = await _firestore
          .collection('users')
          .document(UserController.to.user.id)
          .collection('friends')
          .getDocuments();

      final List<Map<String, dynamic>> allFriends = [];

      for (final DocumentSnapshot friendDoc in userFriends.documents) {
        if (friendDoc.data['email'] == email) {
          allFriends.add(friendDoc?.data);
        }
      }
      return allFriends;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFriendRoom(UserModel friend, String roomId) async {
    try {
      final friendRoom = await _firestore
          .collection('users')
          .document(friend.id)
          .collection('rooms')
          .getDocuments();

      for (final room in friendRoom.documents) {
        if (room['id'] == roomId) {
          return Get.snackbar(friend.name, 'Este usuário já está na sala ',
              snackPosition: SnackPosition.BOTTOM);
        }
      }

      await _firestore
          .collection('users')
          .document(friend.id)
          .collection('rooms')
          .add({'id': roomId});

      await _firestore
          .collection('rooms')
          .document(roomId)
          .collection('users')
          .add({'id': friend.id});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> exitRoom(RoomModel room, String userId) async {
    try {
      final roomDocs = await _firestore
          .collection('users')
          .document(userId)
          .collection('rooms')
          .getDocuments();

      for (final roomDoc in roomDocs.documents) {
        if (roomDoc.data['id'] == room.id) {
          await _firestore
              .collection('users')
              .document(userId)
              .collection('rooms')
              .document(roomDoc.documentID)
              .delete();
        }
      }

      final userRoomDocs = await _firestore
          .collection('rooms')
          .document(room.id)
          .collection('users')
          .getDocuments();

      for (final userRoomDoc in userRoomDocs.documents) {
        if (userRoomDoc.data['id'] == userId) {
          await _firestore
              .collection('rooms')
              .document(room.id)
              .collection('users')
              .document(userRoomDoc.documentID)
              .delete();
        }
      }

      if (userId == room.admUserId) {
        await _firestore.collection('rooms').document(room.id).delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
