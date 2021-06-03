import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';

import '../my_text_field.dart';

class DialogTextEditDelete extends GetView<TextComposerController> {
  final TextEditingController textController;
  final Map<String, dynamic> data;
  final bool mine;

  const DialogTextEditDelete(this.mine,
      {Key key, @required this.textController, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _reset() {
      textController.clear();
    }

    DateTime _ago(Timestamp t) {
      return t.toDate();
    }

    return GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyTextField(
                                controller: textController,
                                hintText: data['text'] as String,
                                inputType: TextInputType.text,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      controller.editSubmitted(
                                          data['id'] as String,
                                          textController.text,
                                          data['idRoom'] as String);
                                      _reset();
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.black87,
                                    ),
                                    label: const Text(
                                      'Editar',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      controller.deleteSubmited(
                                          data['id'] as String,
                                          data['idRoom'] as String);
                                      _reset();
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red[900],
                                    ),
                                    label: const Text(
                                      'Excluir',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (mine)
                Text(
                  data['senderName'].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
              Text(
                data['text'] as String,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              Text(
                DateFormat('Hm', 'en_US').format(
                  _ago(data['time'] as Timestamp),
                ),
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ));
  }
}
