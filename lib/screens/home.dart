import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/chat/chat_screen.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/homePage/image_room_preview.dart';
import 'package:rolagem_dados/widget/my_text_button.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final HomeController _homeController = Get.put(HomeController(Database()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
                await Database().getUser(controller.user.uid);
            _homeController.loadingRooms(controller.user.uid);
          },
          builder: (_) {
            if (_.user.name != null) {
              return Text('Seja bem vindo ${_.user.name}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: _homeController.obx(
                  (state) => ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state[index].imgUrl),
                            ),
                            title: Text(state[index].name),
                            subtitle: Text(state[index].admUserId),
                            autofocus: true,
                            onTap: () => Get.toNamed('/chatscreen',
                                arguments: state[index]),
                          ),
                        );
                      }),
                ),
              ),
              MyTextButton(
                buttonName: 'ChatTest',
                onTap: () {
                  Get.toNamed('/chatscreen');
                },
                bgColor: Colors.white,
                textColor: Colors.black87,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Criar uma nova sala',
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                overflow: Overflow.visible,
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
                            controller: nameController,
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
                                    _homeController.resetImage();
                                  },
                                  bgColor: Colors.transparent,
                                  buttonName: 'Cancelar',
                                  textColor: Colors.black87,
                                ),
                              ),
                              Expanded(
                                child: Obx(() => MyTextButton(
                                      isLoading: controller.isLoading,
                                      onTap: () {
                                        _homeController
                                            .createRoom(nameController.text);

                                        _homeController
                                            .loadingRooms(controller.user.uid);

                                        Get.back();
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
                      top: -60,
                      child: Obx(
                        () => GestureDetector(
                            onTap: () async {
                              _homeController.showImage();
                            },
                            child: _homeController.imgUrl != ''
                                ? ImageRoomPreview(
                                    arquivo: File(_homeController.imgUrl))
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
          },
        ),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
    );
  }
}
