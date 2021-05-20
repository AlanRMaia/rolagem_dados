import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/chat_screen_controller.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/screens/chat/chat_message.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/addfriend/dialog_add_friend.dart';
import 'package:rolagem_dados/widget/chatmessage/dialog_text_edit_delete.dart';
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

    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.group_add),
                onPressed: () {
                  controller.showSearch = !controller.showSearch;
                })
          ],
          backgroundColor: Colors.black87,
          title: Obx(() => controller.showSearch != false
              ? Text(_room.name)
              : MySearchField(
                  controller: _seachController,
                  onChanged: (text) {
                    controller.isEmpty = text.isNotEmpty;
                  },
                  onSubmited: (text) {
                    _clear();
                  },
                  showButton: controller.isEmpty,
                )),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: controller.obx(
                (state) {
                  return ListView.builder(
                    reverse: true, //serve para inverter a ordem da lista
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
