import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/chat_screen_controller.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/screens/chat/chat_message.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/addfriend/dialog_add_friend.dart';
import 'package:rolagem_dados/widget/my_search_field.dart';
import 'text_composer.dart';

class ChatScreen extends GetView<ChatScreenController> {
  ChatScreen();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _seachController = TextEditingController();

  final TextComposerController composerController =
      Get.put(TextComposerController(Database()));

  @override
  Widget build(BuildContext context) {
    void _clear() => _seachController.text = '';
    final RoomModel _room = Get.arguments as RoomModel;

    void _seachFriend() {
      controller.loadFriends(_seachController.text);
      _clear();
      controller.isEmpty = !controller.isEmpty;
    }

    void _loadFriend(String text) {
      controller.loadFriends(text);
      print(_seachController.text);
      print(controller.userFriend.elementAt(0));
    }

    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Obx(() => IconButton(
                icon: controller.showSearch != true
                    ? const Icon(Icons.group_add)
                    : const Icon(Icons.close),
                onPressed: () {
                  controller.showSearch = !controller.showSearch;
                }))
          ],
          toolbarHeight: 80,
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          title: Obx(() => controller.showSearch != true
              ? Text(_room.name)
              : MySearchField(
                  controller: _seachController,
                  onChanged: (text) {
                    controller.isEmpty = text.isNotEmpty;
                  },
                  onSubmited: (text) {
                    controller.loadFriends(text);
                  },
                  showButton: controller.isEmpty,
                  voidCallback: _seachFriend,
                )),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => controller.userFriend.isNotEmpty
                ? SizedBox(
                    height: 69,
                    child: ListView.builder(
                        itemCount: controller.userFriend.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 40, right: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return DialogAddFriend(
                                            user: controller.userFriend[index],
                                            voidCallback: () {
                                              controller.addFriendRoom(
                                                  controller
                                                      .userFriend[index].id,
                                                  _room.id);
                                            },
                                            voidCallbackReload: () {
                                              controller.userFriend.clear();
                                              controller.showSearch = false;
                                            },
                                          );
                                        });
                                  },
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                    controller.userFriend[index].image,
                                  )),
                                  title: Text(
                                    controller.userFriend[index].name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    controller.userFriend[index].id,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      controller.userFriend.clear();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                  autofocus: true,
                                  dense: true,
                                ) ??
                                const CircularProgressIndicator(),
                          );
                        }),
                  )
                : Container()),
            Expanded(
              child: controller.obx(
                (state) {
                  return ListView.builder(
                    reverse: true, //serve para inverter a ordem da lista
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      print('search');
                      return ChatMessage(
                        data: state[index],
                        mine: state[index]
                            .containsValue(UserController.to.user?.id),
                      );
                    },
                  );
                },
                onError: (error) {
                  Get.snackbar('Error ao carregar a mensagem', error,
                      snackPosition: SnackPosition.TOP);
                },
              ),
            ),
            Obx(() {
              return composerController.isLoading
                  ? const LinearProgressIndicator()
                  : Container();
            }),
            const Divider(height: 1),
            Container(
              decoration: BoxDecoration(color: Get.theme.cardColor),
              child: TextComposer(roomModel: _room),
            )
          ],
        ),
      ),
    );
  }
}
