import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class FileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments as Map<String, dynamic>;
    print(data['fileUrl']);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Get.back(),
          ),
          title: Text(data['fileName'].toString()),
        ),
        body: data['type'] != null
            ? PDFView(
                filePath: data['fileUrl'].toString(),
              )
            : Container(
                alignment: Alignment.center,
                child: Image.network(
                  data['fileUrl'].toString(),
                  fit: BoxFit.cover,
                  height: double.infinity,
                )),
      ),
    );
  }
}
