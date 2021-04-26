import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

class TextComposer extends StatelessWidget {
  final RoomModel roomModel;
  TextComposer({Key key, this.roomModel}) : super(key: key);

  final TextEditingController _textController = TextEditingController();
  final Database _database = Get.put(Database());
  final TextComposerController controller = Get.put(TextComposerController());

  //serve para acompanhar a mudança de estado da caixa de texto. Se ela está preenchida ou não antes de enviar a mensagem.

  void _reset() {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      //sempre que for diferenciar um tema em uma parte especifica tem que usar o widget Theme(nesse caso o IconTheme)
      data: IconThemeData(color: Get.theme.accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: Get.theme.platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]),
                ),
              )
            : null,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.photo_camera),
              onPressed: () async {
                final picker = ImagePicker();
                final imgFile =
                    await picker.getImage(source: ImageSource.camera);
                if (imgFile == null) return;
                _database.handleSubmitted(imgFile: File(imgFile.path));
                _reset();
              },
            ),
            Expanded(
                child: Obx(() => TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                          hintText: 'Enviar uma mensagem'),
                      onChanged: (text) {
                        controller.isComposing = text.isNotEmpty;
                      },
                      onSubmitted: (text) {
                        if (controller.isComposing) {
                          _database.handleSubmitted(
                              text: text, room: roomModel);
                          _reset();
                        } else {
                          Get.snackbar(
                            'Erro ao tentar enviar a mensagem',
                            'Sua caixa de texto está vazia',
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                    ))),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Get.theme.platform == TargetPlatform.iOS
                  ? Obx(() => CupertinoButton(
                        onPressed: controller.isComposing
                            ? () {
                                _database.handleSubmitted(
                                    text: _textController.text,
                                    room: roomModel);
                                _reset();
                              }
                            : null,
                        child: const Icon(Icons.send),
                      ))
                  : Obx(() => IconButton(
                        onPressed: controller.isComposing
                            ? () {
                                _database.handleSubmitted(
                                    text: _textController.text,
                                    room: roomModel);
                                _reset();
                              }
                            : null,
                        icon: const Icon(Icons.send),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
