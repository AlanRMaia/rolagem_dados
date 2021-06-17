import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';

class DialogDownloadProgress extends GetView<TextComposerController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 250,
              width: 250,
              color: Colors.grey.shade50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    controller.progress.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ))));
  }
}
