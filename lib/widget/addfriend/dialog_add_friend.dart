import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_text_button.dart';

class DialogAddFriend extends StatelessWidget {
  final VoidCallback voidCallback;
  final VoidCallback voidCallbackReload;
  final Map<String, dynamic> data;

  const DialogAddFriend(
      {Key key, this.voidCallback, this.data, this.voidCallbackReload})
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
                      'Deseja a adicionar ${data['name']} como amigo?',
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
                  backgroundImage: NetworkImage(data['image'] as String),
                ),
                const SizedBox(height: 5),
                Text(
                  data['name'] as String,
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
