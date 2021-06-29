import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';

import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/screens/file_view.dart';

class DialogExitRoom extends GetView<HomeController> {
  final RoomModel room;
  final UserModel user;
  const DialogExitRoom({
    @required this.room,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          room.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                          onPressed: () async {},
                          icon: const Icon(
                            Icons.cancel_sharp,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          )),
                      OutlinedButton.icon(
                        onPressed: () {
                          controller.exitRoom(room, user.id);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Sair',
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
    ));
  }
}
