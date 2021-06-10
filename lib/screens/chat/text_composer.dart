import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

class TextComposer extends StatefulWidget {
  final RoomModel roomModel;
  const TextComposer({Key key, this.roomModel}) : super(key: key);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final TextEditingController _textController = TextEditingController();
  final TextComposerController controller = TextComposerController(Database());
  var random = Random();
  bool _isComposing = false;

  void _reset() {
    setState(() {
      _textController.clear();
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () async {
              final picker = ImagePicker();
              final imgFile = await picker.getImage(source: ImageSource.camera);
              if (imgFile == null) return;
              controller.handleSubmitted(
                  imgFile: File(imgFile.path), room: widget.roomModel);
              _reset();
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration:
                  const InputDecoration(hintText: 'Enviar uma mensagem'),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                if (_isComposing) {
                  controller.handleSubmitted(
                      text: text, room: widget.roomModel);
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
                            room: widget.roomModel);

                        break;
                      case 'assets/images/noun_d6_2453695.png':
                        controller.imgDados =
                            'assets/images/noun_d6_2453695.png';
                        controller.handleSubmitted(
                            text:
                                "D6 - Resultado: ${(1 + random.nextInt(7 - 1)).toString()}",
                            room: widget.roomModel);
                        break;
                      case 'assets/images/noun_d8_2453699.png':
                        controller.imgDados =
                            'assets/images/noun_d8_2453699.png';
                        controller.handleSubmitted(
                            text:
                                "D8 - Resultado: ${(1 + random.nextInt(9 - 1)).toString()}",
                            room: widget.roomModel);
                        break;
                      case 'assets/images/noun_d10_2453698.png':
                        controller.imgDados =
                            'assets/images/noun_d10_2453698.png';
                        controller.handleSubmitted(
                            text:
                                "D10 - Resultado: ${(1 + random.nextInt(11 - 1)).toString()}",
                            room: widget.roomModel);
                        break;
                      case 'assets/images/noun_d12_2453697.png':
                        controller.imgDados =
                            'assets/images/noun_d12_2453697.png';
                        controller.handleSubmitted(
                            text:
                                "D12 - Resultado: ${(1 + random.nextInt(13 - 1)).toString()}",
                            room: widget.roomModel);
                        break;
                      case 'assets/images/noun_D20_2453700.png':
                        controller.imgDados =
                            'assets/images/noun_D20_2453700.png';
                        controller.handleSubmitted(
                            text:
                                "D20 - Resultado: ${(1 + random.nextInt(21 - 1)).toString()}",
                            room: widget.roomModel);
                        break;
                      default:
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Get.theme.platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        onPressed: _isComposing
                            ? () {
                                controller.handleSubmitted(
                                    text: _textController.text,
                                    room: widget.roomModel);
                                _reset();
                              }
                            : null,
                        child: const Icon(Icons.send),
                      )
                    : IconButton(
                        onPressed: _isComposing
                            ? () {
                                controller.handleSubmitted(
                                    text: _textController.text,
                                    room: widget.roomModel);
                                _reset();
                              }
                            : null,
                        icon: const Icon(Icons.send),
                      ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
