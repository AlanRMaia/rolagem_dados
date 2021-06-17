import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;

class DataDio {
  Dio dio;

  Future<List<Directory>> _getExternalStoragePath() async {
    return pathprovider.getExternalStorageDirectories(
        type: pathprovider.StorageDirectory.downloads);
  }

  Future downloadAndSaveFileToStorage(String urlPath, String fileName,
      Function(bool value) func, Function(String value) funcProgress) async {
    // ProgressDialog pr;
    // pr = ProgressDialog(context,type: ProgressDialogType.Normal);
    // pr.style(message: 'Downloading file ...');

    try {
      //show dialog progress
      //await pr.show();

      final dirList = await _getExternalStoragePath();
      final path = dirList[0].path;
      final file = File('$path/$fileName');
      await dio.download(
        urlPath,
        file.path,
        onReceiveProgress: (count, total) {
          func(true);
          funcProgress('${((count / total) * 100).toStringAsFixed(0)}%');

          //update dialog progress

          //pr.update(message: 'Fazendo download: ${progress}');
        },
      );

      //pr.hide();
    } catch (e) {
      print(e);
    }
  }
}
