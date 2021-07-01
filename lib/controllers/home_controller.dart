import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

class HomeController extends GetxController with StateMixin<List<RoomModel>> {
  final Database _database;
  final Firestore _firestore = Firestore.instance;

  HomeController(this._database);

  @override
  void onInit() {
    loadRooms(UserController.to.user.id);

    super.onInit();
  }

  final picker = ImagePicker();
  File _imgFile;
  final RxString _imgUrl = ''.obs;
  final _indexTab = 3.obs;

  File get imgFile => _imgFile;
  set imgFile(File value) => _imgFile = value;

  String get imgUrl => _imgUrl.value;

  set imgUrl(String value) {
    _imgUrl.value = value;
  }

  set indexTab(int value) => _indexTab.value = value;
  int get indexTab => _indexTab.value;

  // final _rooms = <Map<String, dynamic>>[].obs;

  // List<Map<String, dynamic>> get rooms => _rooms;

  // set rooms(List<Map<String, dynamic>> value) => _rooms.addAll(value);

  Future<void> showImage() async {
    final pickerfile = await picker.getImage(source: ImageSource.camera);
    _imgFile = File(pickerfile.path);
    if (pickerfile != null) {
      imgUrl = pickerfile.path;
    }
  }

  void resetImage() => _imgUrl.value = '';

  Future<void> createRoom(String name) async {
    _database.roomCreateSubmitted(name: name, imgFile: imgFile);
  }

  Future<void> loadRooms(String userId) async {
    change([], status: RxStatus.loading());
    try {
      final List<RoomModel> _rooms = [];
      _firestore
          .collection('users')
          .document(userId)
          .collection('rooms')
          .snapshots()
          .listen((snapshot) async {
        _rooms.clear();

        for (final DocumentSnapshot room in snapshot.documents) {
          final DocumentSnapshot roomDoc = await _firestore
              .collection('rooms')
              .document(room?.data['id'].toString())
              .get();

          _rooms?.add(RoomModel?.fromMap(roomDoc?.data));
        }
        change(_rooms, status: RxStatus.success());
      });
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
