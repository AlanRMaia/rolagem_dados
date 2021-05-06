import 'dart:io';

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
      ),
    );
  }
}
