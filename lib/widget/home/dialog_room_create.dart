import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';
import 'package:rolagem_dados/widget/homePage/image_room_preview.dart';

import '../my_text_button.dart';
import '../my_text_field.dart';

class DialogRoomCreate extends StatelessWidget {
  final HomeController controller;
  final AuthController controllerAuth;
  final TextEditingController textController;
  final VoidCallback voidCallback;

  const DialogRoomCreate(
      {Key key,
      @required this.controller,
      @required this.textController,
      this.controllerAuth,
      this.voidCallback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 300,
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  const Text(
                    'Adicione uma imagem a sua sala',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Criação de Salas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  MyTextField(
                    controller: textController,
                    hintText: 'Name',
                    inputType: TextInputType.name,
                    textColor: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextButton(
                          onTap: () {
                            Get.back();
                            controller.resetImage();
                            textController.clear();
                          },
                          bgColor: Colors.transparent,
                          buttonName: 'Cancelar',
                          textColor: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Obx(() => MyTextButton(
                              isLoading: controllerAuth.isLoading,
                              onTap: () async {
                                Get.back();
                                controller.createRoom(textController.text);
                                controller.resetImage();
                                controller.imgFile = null;
                                textController.clear();
                              },
                              buttonName: 'Criar',
                              bgColor: Colors.transparent,
                              textColor: Colors.black87,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: -30,
              child: Obx(
                () => GestureDetector(
                    onTap: () async {
                      controller.showImage();
                    },
                    child: controller.imgUrl != ''
                        ? ImageRoomPreview(arquivo: File(controller.imgUrl))
                        : const ImageRoomPreview(
                            icon: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.black87,
                              size: 60,
                            ),
                          )),
              )),
        ],
      ),
    );
  }
}
