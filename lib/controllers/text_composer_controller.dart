import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:rolagem_dados/models/firebase_file.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

import 'user_controller.dart';

class TextComposerController extends GetxController {
  final Database _database;
  final _isComposing = false.obs;
  final _isLoading = false.obs;
  final _isLoadingPhoto = false.obs;
  final _isRecomend = false.obs;
  final _imgDados = 'assets/images/noun_D20_2453700.png'.obs;
  final ReceivePort _receivePort = ReceivePort();

  TextComposerController(this._database);

  Dio dio;

  set imgDados(String value) => _imgDados.value = value;
  String get imgDados => _imgDados.value;

  set isComposing(bool value) => _isComposing.value = value;
  bool get isComposing => _isComposing.value;

  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  set isLoadingPhoto(bool value) => _isLoadingPhoto.value = value;
  bool get isLoadingPhoto => _isLoadingPhoto.value;

  set isRecomend(bool value) => _isRecomend.value = value;
  bool get isRecomend => _isRecomend.value;

  final _progress = 0.obs;
  set progress(int value) => _progress.value = value;
  int get progress => _progress.value;

  final Rx<StorageUploadTask> _taskStatus = Rx<StorageUploadTask>();

  StorageUploadTask get taskStatus => _taskStatus.value;

  set taskStatus(StorageUploadTask value) {
    _taskStatus.value = value;
  }

  // Future isLoadingDownload(bool value) async {
  //   isLoading = value;
  // }

  // Future onProgress(String value) async {
  //   progress = value;
  // }

  @override
  void onInit() {
    dio = Dio();
    super.onInit();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, 'downloading');

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      progress = message[2] as int;
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    final SendPort sendPort = IsolateNameServer.lookupPortByName('downloading');

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  Widget buildUploadStatus() => StreamBuilder<StorageTaskSnapshot>(
        stream: taskStatus.onComplete.asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot?.data;
            final progress = snap.bytesTransferred / snap.totalByteCount;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  Future<void> handleSubmitted(
      {String text, File file, RoomModel room, String type}) async {
    if (UserController.to.user != null) {
      final FirebaseFile firebasefile = FirebaseFile();

      if (file != null) {
        final task = _database.storageUpload(file);
        isLoading = true;

        final snapshot = await task?.onComplete;
        if (snapshot == null) return;

        firebasefile?.name = snapshot.storageMetadata.name.toString();
        firebasefile?.url = await _database.storageDownloadUrl(task);
        firebasefile?.byteTotal = snapshot.storageMetadata.sizeBytes;
      }

      _database.handleSubmitted(
        text: text,
        user: UserController.to.user,
        imgFile: file,
        room: room,
        file: firebasefile,
        type: type,
      );

      isLoading = false;
      // isLoading
      //     ? Get.snackbar(firebasefile?.name, firebasefile?.url,
      //         icon: const SizedBox(
      //             height: 20, width: 20, child: CircularProgressIndicator()),
      //         messageText: const Text(
      //           'Downloading...',
      //           style: TextStyle(
      //             fontSize: 15,
      //           ),
      //         ),
      //         titleText: Text(
      //           firebasefile?.name,
      //           style:
      //               const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      //         ),
      //         maxWidth: 300,
      //         snackPosition: SnackPosition.BOTTOM)
      //     : Get.snackbar(firebasefile?.name, firebasefile?.url,
      //         messageText: const Text(
      //           'Download completo',
      //           style: TextStyle(fontSize: 15),
      //         ),
      //         titleText: Text(
      //           firebasefile?.name,
      //           style: const TextStyle(
      //             fontSize: 10,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         maxWidth: 300,
      //         snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> editSubmitted(
      {String idMessage, String message, String idRoom, int recomend}) async {
    var valorRecomend = recomend;
    if (recomend != null) {
      if (isRecomend != false) {
        valorRecomend++;
      } else {
        valorRecomend--;
      }
    }
    await _database.editSubmitted(
        idMessage: idMessage,
        message: message,
        idRoom: idRoom,
        recomend: valorRecomend);
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

  Future<void> documentsDownload(String urlPath, String fileName) async {
    try {
      _downloadAndSaveFileToStorage(
        urlPath,
        fileName,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<Directory>> _getExternalStoragePath() async {
  //   return p.getExternalStorageDirectories(
  //       type: p.StorageDirectory.downloads);
  // }

  Future _downloadAndSaveFileToStorage(
    String urlPath,
    String fileName,
  ) async {
    // ProgressDialog pr;
    // pr = ProgressDialog(context,type: ProgressDialogType.Normal);
    // pr.style(message: 'Downloading file ...');

    try {
      //show dialog progress
      //await pr.show();

      final status = await Permission.storage.request();
      final dir = await p.getExternalStorageDirectories(
          type: p.StorageDirectory.downloads);
      isLoading = true;

      if (status.isGranted) {
        final id = await FlutterDownloader.enqueue(
          url: urlPath,
          savedDir: dir.last.path,
          fileName: basename(fileName),
          showNotification: true,
          openFileFromNotification: true,
        );
      }

      // final ref = FirebaseStorage.instance
      //     .ref()
      //     .child('/Imagemessages')
      //     .child(fileName);

      // final file = File('${dir.path}/$fileName.jpg ');
      // isLoading = true;
      // ref.writeToFile(file);
      // isLoading = false;
      // print(file.path);
      //pr.hide();
      isLoading = false;
      isLoading
          ? Get.snackbar(
              basename(fileName),
              dir.toString(),
              icon: const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
              messageText: const Text(
                'Downloading...',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              titleText: Text(
                basename(fileName),
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              maxWidth: 300,
            )
          : Get.snackbar(
              basename(fileName),
              dir.toString(),
              messageText: const Text(
                'Download completo',
                style: TextStyle(fontSize: 15),
              ),
              titleText: Text(
                basename(fileName),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              maxWidth: 300,
            );
    } catch (e) {
      print(e);
    }
  }
}
