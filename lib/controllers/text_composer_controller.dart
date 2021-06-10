import 'dart:io';

import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

import 'user_controller.dart';

class TextComposerController extends GetxController {
  final Database _database;
  final _isComposing = false.obs;
  final _isLoading = false.obs;
  final _imgDados = 'assets/images/noun_D20_2453700.png'.obs;

  TextComposerController(this._database);

  set imgDados(String value) => _imgDados.value = value;
  String get imgDados => _imgDados.value;

  set isComposing(bool value) => _isComposing.value = value;
  bool get isComposing => _isComposing.value;

  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  Future<void> handleSubmitted(
      {String text, File imgFile, RoomModel room}) async {
    if (UserController.to.user != null) {
      String url;
      if (imgFile != null) {
        final task = _database.storageUpload(imgFile);
        isLoading = true;
        url = await _database.storageDownloadUrl(task);
        isLoading = false;
      }

      _database.handleSubmitted(
          text: text,
          user: UserController.to.user,
          imgFile: imgFile,
          room: room,
          url: url);
    }
  }

  Future<void> editSubmitted(
      String idMessage, String message, String idRoom) async {
    await _database.editSubmitted(idMessage, message, idRoom);
  }

  Future<void> deleteSubmited(String idMessage, String idRoom) async {
    await _database.deleteSubmited(idMessage, idRoom);
  }

  final List<String> dados = [
    'assets/images/noun_d4_2453696.png',
    'assets/images/noun_d6_2453695.png',
    'assets/images/noun_d8_2453699.png',
    'assets/images/noun_d10_2453698.png',
    'assets/images/noun_d12_2453697.png',
    'assets/images/noun_D20_2453700.png'
  ];
}
