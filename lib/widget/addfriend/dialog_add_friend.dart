import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import '../my_text_button.dart';

class DialogAddFriend extends StatelessWidget {
  final VoidCallback voidCallback;
  final VoidCallback voidCallbackReload;
  final Map<String, dynamic> data;
  final UserModel user;
  final RoomModel model;

  const DialogAddFriend(
      {Key key,
      this.voidCallback,
      this.data,
      this.voidCallbackReload,
      this.model,
      this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      data != null
                          ? 'Deseja a adicionar ${data['name']} como amigo?'
                          : 'Deseja a adicionar ${user.name} como amigo?',
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
                  backgroundImage: NetworkImage(
                      data != null ? data['image'].toString() : user.image),
                ),
                const SizedBox(height: 5),
                Text(
                  data != null ? data['name'].toString() : user.name,
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
