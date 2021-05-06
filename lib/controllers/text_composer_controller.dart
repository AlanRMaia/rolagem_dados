import 'dart:io';

import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

import 'user_controller.dart';

class TextComposerController extends GetxController {
  final Database _database;
  final _isComposing = false.obs;
  final _isLoading = false.obs;

  TextComposerController(this._database);

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
}
