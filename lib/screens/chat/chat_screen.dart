import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/chat_screen_controller.dart';
import 'package:rolagem_dados/controllers/room_model_controller.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/screens/bottom_bar_pages.dart';
import 'package:rolagem_dados/screens/chat/chat_message.dart';
import 'package:rolagem_dados/screens/home.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/my_search_field.dart';
import 'package:rolagem_dados/widget/search_chat_result_list%20.dart';

import 'text_composer.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final TextEditingController _textController = TextEditingController();

  final TextEditingController _seachController = TextEditingController();

  final TextComposerController _composerController =
      Get.put(TextComposerController(Database()));

  final ChatScreenController controller =
      Get.put(ChatScreenController(Database()));

  @override
  void dispose() {
    _seachController.dispose();

    super.dispose();
  }

  final _room = Get.arguments;

  @override
  Widget build(BuildContext context) {
    void _clear() => _seachController.text = '';

    void _seachFriend() {
      controller.loadFriends(_seachController.text);
      _clear();
      controller.isEmpty = !controller.isEmpty;
    }

    // void _loadFriend(String text) {
    //   controller.loadFriends(text);
    // }

    return SafeArea(
        bottom: false,
        top: false,
        child: GestureDetector(
          onTap: () => Get.focusScope.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Obx(() => _room.admUserId == UserController.to.user.id
                    ? IconButton(
                        icon: controller.showSearch != true
                            ? const Icon(Icons.group_add)
                            : const Icon(Icons.close),
                        onPressed: () {
                          controller.showSearch = !controller.showSearch;
                        })
                    : Container())
              ],
              toolbarHeight: 60,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              title: Obx(() => controller.showSearch != false
                  ? SizedBox(
                      height: 45,
                      child: MySearchField(
                        theme: Get.isDarkMode,
                        controller: _seachController,
                        onChanged: (text) {
                          controller.isEmpty = text.isNotEmpty;
                        },
                        onSubmited: (text) {
                          controller.loadFriends(text);
                        },
                        showButton: controller.isEmpty,
                        voidCallback: _seachFriend,
                      ),
                    )
                  : ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_room.imgUrl.toString()),
                      ),
                      title: Text(_room.name.toString()),
                    )),
              centerTitle: true,
              elevation: 0,
            ),
            body: Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: controller.obx(
                        (state) {
                          return ListView.builder(
                            reverse:
                                true, //serve para inverter a ordem da lista
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              return ChatMessage(
                                data: state[index],
                                mine: state[index]
                                    .containsValue(UserController.to.user?.id),
                              );
                            },
                          );
                        },
                        // ignore: missing_return
                        onError: (error) {
                          Get.snackbar('Error ao carregar a mensagem', error,
                              snackPosition: SnackPosition.TOP);
                        },
                      ),
                    ),
                    const SizedBox(height: 55),
                  ],
                ),
                Obx(
                  () => controller.userFriend.isNotEmpty
                      ? SizedBox(
                          child: ListView.builder(
                              itemCount: controller.userFriend.length,
                              itemBuilder: (context, index) {
                                return SearchChatResultList(
                                  user: controller.userFriend[index],
                                  onPressed: () =>
                                      controller.userFriend.clear(),
                                  voidCallback: () {
                                    controller.addFriendRoom(
                                        controller.userFriend[index],
                                        _room.id.toString());
                                    // _composerController.handleSubmitted(
                                    //     text:
                                    //         '${controller.userFriend[index].name} entrou na sala',
                                    //     room: room);
                                  },
                                  voidCallbackReload: () {
                                    controller.userFriend.clear();
                                    controller.showSearch = false;
                                  },
                                );
                              }),
                        )
                      : Container(),
                ),
                // Positioned(
                //   bottom: 59,
                //   height: 20,
                //   width: Get.mediaQuery.size.width,
                //   child: Obx(() {
                //     return _composerController.isLoading != false
                //         // ignore: avoid_unnecessary_containers
                //         ? Container(
                //             child: Row(
                //               children: [
                //                 const SizedBox(width: 10),
                //                 const CircularProgressIndicator(),
                //                 const Text(
                //                   '  Carregando ...',
                //                   style: TextStyle(color: Colors.white),
                //                 )
                //               ],
                //             ),
                //           )
                //         : Container();
                //   }),
                // ),
                Positioned(
                  bottom: 0,
                  height: 56,
                  width: Get.mediaQuery.size.width,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.grey.shade300),
                        child: TextComposer(_room as RoomModel),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
