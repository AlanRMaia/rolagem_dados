import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

class TextComposer extends StatelessWidget {
  final RoomModel roomModel;

  TextComposer(this.roomModel);

  final TextEditingController _textController = TextEditingController();
  final TextComposerController controller = TextComposerController(Database());

  @override
  Widget build(BuildContext context) {
    final random = Random();

    void _reset() {
      _textController.clear();
      controller.isComposing = false;
    }

    return Container(
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
          Container(
            width: 40,
            child: IconButton(
              color: Get.isDarkMode ? Colors.black87 : Colors.white,
              icon: const Icon(Icons.photo_camera),
              onPressed: () async {
                final picker = ImagePicker();
                final imgFile =
                    await picker.getImage(source: ImageSource.camera);
                if (imgFile == null) return;
                controller.handleSubmitted(
                    file: File(imgFile.path), room: roomModel);
                _reset();
              },
            ),
          ),
          Container(
            child: PopupMenuButton(
              tooltip: 'Selecione o arquivo',
              icon: Icon(
                Icons.attach_file_rounded,
                color: Get.isDarkMode ? Colors.black87 : Colors.white,
                size: 24,
              ),
              iconSize: 30,
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  // ignore: sort_child_properties_last
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.image),
                  ),
                  value: 'image',
                ),
                const PopupMenuItem(
                  // ignore: sort_child_properties_last
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.picture_as_pdf),
                  ),
                  value: 'pdf',
                ),
              ],
              onSelected: (value) async {
                if (value != 'pdf') {
                  final picker = ImagePicker();
                  final imgFile =
                      await picker.getImage(source: ImageSource.gallery);
                  if (imgFile == null) return;
                  controller.handleSubmitted(
                      file: File(imgFile.path), room: roomModel, type: 'image');
                  _reset();
                } else {
                  final result = await FilePicker.getFile(
                    type: FileType.CUSTOM,
                    fileExtension: 'pdf',
                  );

                  if (result == null) return;
                  final path = result.path;
                  controller.handleSubmitted(
                    file: File(path),
                    room: roomModel,
                    type: 'pdf',
                  );
                  _reset();
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Enviar uma mensagem',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    )),
                onChanged: (text) {
                  controller.isComposing = text.isNotEmpty;
                },
                onSubmitted: (text) {
                  if (controller.isComposing) {
                    controller.handleSubmitted(text: text, room: roomModel);
                    _reset();
                  } else {
                    Get.snackbar(
                      'Erro ao tentar enviar a mensagem',
                      'Sua caixa de texto está vazia',
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
              ),
            ),
          ),
          Row(
            children: [
              Obx(
                () => PopupMenuButton(
                  tooltip: 'Escolha o seu dado',
                  icon: Image.asset(controller.imgDados),
                  iconSize: 30,
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child:
                              Image.asset('assets/images/noun_d4_2453696.png')),
                      value: 'assets/images/noun_d4_2453696.png',
                    ),
                    PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child:
                              Image.asset('assets/images/noun_d6_2453695.png')),
                      value: 'assets/images/noun_d6_2453695.png',
                    ),
                    PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child:
                              Image.asset('assets/images/noun_d8_2453699.png')),
                      value: 'assets/images/noun_d8_2453699.png',
                    ),
                    PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                              'assets/images/noun_d10_2453698.png')),
                      value: 'assets/images/noun_d10_2453698.png',
                    ),
                    PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                              'assets/images/noun_d12_2453697.png')),
                      value: 'assets/images/noun_d12_2453697.png',
                    ),
                    PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                              'assets/images/noun_D20_2453700.png')),
                      value: 'assets/images/noun_D20_2453700.png',
                    ),
                  ],
                  onSelected: (value) {
                    switch (value.toString()) {
                      case 'assets/images/noun_d4_2453696.png':
                        controller.imgDados =
                            'assets/images/noun_d4_2453696.png';
                        controller.handleSubmitted(
                            text:
                                "D4 - Resultado: ${(1 + random.nextInt(5 - 1)).toString()}",
                            room: roomModel);

                        break;
                      case 'assets/images/noun_d6_2453695.png':
                        controller.imgDados =
                            'assets/images/noun_d6_2453695.png';
                        controller.handleSubmitted(
                            text:
                                "D6 - Resultado: ${(1 + random.nextInt(7 - 1)).toString()}",
                            room: roomModel);
                        break;
                      case 'assets/images/noun_d8_2453699.png':
                        controller.imgDados =
                            'assets/images/noun_d8_2453699.png';
                        controller.handleSubmitted(
                            text:
                                "D8 - Resultado: ${(1 + random.nextInt(9 - 1)).toString()}",
                            room: roomModel);
                        break;
                      case 'assets/images/noun_d10_2453698.png':
                        controller.imgDados =
                            'assets/images/noun_d10_2453698.png';
                        controller.handleSubmitted(
                            text:
                                "D10 - Resultado: ${(1 + random.nextInt(11 - 1)).toString()}",
                            room: roomModel);
                        break;
                      case 'assets/images/noun_d12_2453697.png':
                        controller.imgDados =
                            'assets/images/noun_d12_2453697.png';
                        controller.handleSubmitted(
                            text:
                                "D12 - Resultado: ${(1 + random.nextInt(13 - 1)).toString()}",
                            room: roomModel);
                        break;
                      case 'assets/images/noun_D20_2453700.png':
                        controller.imgDados =
                            'assets/images/noun_D20_2453700.png';
                        controller.handleSubmitted(
                            text:
                                "D20 - Resultado: ${(1 + random.nextInt(21 - 1)).toString()}",
                            room: roomModel);
                        break;
                      default:
                    }
                  },
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 4),
              //   child: Get.theme.platform == TargetPlatform.iOS
              //       ? CupertinoButton(
              //           onPressed: _isComposing
              //               ? () {
              //                   controller.handleSubmitted(
              //                       text: _textController.text,
              //                       room: widget.roomModel);
              //                   _reset();
              //                 }
              //               : null,
              //           child: const Icon(Icons.send),
              //         )
              //       : IconButton(
              //           onPressed: _isComposing
              //               ? () {
              //                   controller.handleSubmitted(
              //                       text: _textController.text,
              //                       room: widget.roomModel);
              //                   _reset();
              //                 }
              //               : null,
              //           icon: const Icon(Icons.send),
              //         ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
