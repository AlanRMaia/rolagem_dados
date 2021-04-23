import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/services/data_base.dart';

class HomeController extends GetxController with StateMixin<List<RoomModel>> {
  final Database _database;
  HomeController(this._database);

  final picker = ImagePicker();
  File _imgFile;
  final RxString _imgUrl = ''.obs;

  File get imgFile => _imgFile;
  set imgFile(File value) => _imgFile = value;

  String get imgUrl => _imgUrl.value;

  set imgUrl(String value) {
    _imgUrl.value = value;
  }

  // final _rooms = <RoomModel>[].obs;

  // List<RoomModel> get rooms => _rooms;

  // set rooms(List<RoomModel> value) => _rooms.addAll(value);

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

  Future<void> loadingRooms(String userId) async {
    change([], status: RxStatus.loading());
    try {
      final rooms = await _database.loadRooms(userId);

      change(rooms, status: RxStatus.success());
    } catch (e) {
      print('Erro ao dar loading nas salas $e');
      change([], status: RxStatus.error());
    }
  }
}
