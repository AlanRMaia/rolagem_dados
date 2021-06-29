import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/widget/my_search_field.dart';
import '../my_text_button.dart';

class DialogAddFriendRoom extends StatelessWidget {
  final VoidCallback voidCallback;
  final VoidCallback voidCallbackReload;
  final Map<String, dynamic> data;
  final UserModel model;
  final TextEditingController editingController;
  final ValueChanged<String> onChanged;
  final bool showButton;
  final Function(String) onSubmited;

  const DialogAddFriendRoom(
      {Key key,
      this.voidCallback,
      this.data,
      this.voidCallbackReload,
      this.model,
      this.editingController,
      this.onChanged,
      this.showButton,
      this.onSubmited})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map map = {
      'text': 'Deseja a adicionar ${data['name'] ?? model.name} como amigo?'
    };

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            height: 200,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18))),
                  height: 120,
                ),
                Column(
                  children: [
                    if (data == null && model == null) const MySearchField(),
                    Text(
                      map['text'] as String,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextButton(
                            onTap: () {
                              Get.back();
                            },
                            bgColor: Colors.transparent,
                            buttonName: 'Cancelar',
                            textColor: Colors.black87,
                          ),
                        ),
                        Expanded(
                            child: MyTextButton(
                          onTap: () async {
                            voidCallback();
                            voidCallbackReload();

                            Get.back();
                          },
                          buttonName: 'Adicionar',
                          bgColor: Colors.transparent,
                          textColor: Colors.black87,
                        )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: -40,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(data['image'] as String ?? model.image),
                ),
                const SizedBox(height: 5),
                Text(
                  data['name'] as String ?? model.name,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
