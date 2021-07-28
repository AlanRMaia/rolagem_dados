import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rolagem_dados/constants/firebase.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/utils/showLoading.dart';

class HomeController extends GetxController with StateMixin<List<RoomModel>> {
  final Database _database;

  HomeController(this._database);

  final picker = ImagePicker();
  File _imgFile;
  final RxString _imgUrl = ''.obs;
  final _indexTab = 3.obs;
  final _isExpanded = false.obs;
  final _isLoading = false.obs;

  // ignore: unnecessary_getters_setters
  File get imgFile => _imgFile;
  // ignore: unnecessary_getters_setters
  set imgFile(File value) => _imgFile = value;

  String get imgUrl => _imgUrl.value;

  set imgUrl(String value) {
    _imgUrl.value = value;
  }

  set indexTab(int value) => _indexTab.value = value;
  int get indexTab => _indexTab.value;

  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  set isExpanded(bool value) => _isExpanded.value = value;
  bool get isExpanded => _isExpanded.value;

  // final RxList<RoomModel> _rooms = RxList<RoomModel>([]);

  // List<RoomModel> get rooms => _rooms;

  // set rooms(List<RoomModel> value) => _rooms.addAll(value);

  Future<void> showImage() async {
    final pickerfile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 800,
        maxWidth: 800);
    _imgFile = File(pickerfile.path);
    if (pickerfile != null) {
      imgUrl = pickerfile.path;
    }
  }

  void resetImage() => _imgUrl.value = '';

  Future<void> createRoom(String name) async {
    if (imgFile == null) {
      return Get.snackbar(
          'Sala $name não foi criada', 'adicionar uma imagem é obrigatório');
    }
    _database.roomCreateSubmitted(name: name, imgFile: imgFile);
  }

  Future<void> loadRooms(String userId) async {
    change([], status: RxStatus.loading());
    try {
      final List<RoomModel> _rooms = [];
      // _firestore
      //     .collection('users')
      //     .document(userId)
      //     .collection('rooms')
      //     .snapshots()
      //     .listen((snapshot) async {
      //   _rooms.clear();

      //   for (final DocumentSnapshot room in snapshot.documents) {
      //     final DocumentSnapshot roomDoc = await _firestore
      //         .collection('rooms')
      //         .document(room?.data['id'].toString())
      //         .get();

      //     _rooms?.add(RoomModel?.fromMap(roomDoc?.data));
      //   }
      //   change(_rooms, status: RxStatus.success());
      // });

      _rooms.addAll(await _database.loadRooms(userId));
      change(_rooms, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> exitRoom(RoomModel room, String userId) async {
    try {
      await _database.exitRoom(room, userId);
    } catch (e) {
      rethrow;
    }
  }
}
