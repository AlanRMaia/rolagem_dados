import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/chat_screen_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/chat/chat_message.dart';
import 'text_composer.dart';

class ChatScreen extends GetView<ChatScreenController> {
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat App'),
          centerTitle: true,
          elevation: Get.theme.platform == TargetPlatform.iOS ? 0 : 4,
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
                          state[index],
                          state[index]
                              .containsValue(UserController.to.user?.id));
                    },
                  );
                },
                onError: (error) {
                  Get.snackbar('Error ao carregar a mensagem', error,
                      snackPosition: SnackPosition.TOP);
                },
              ),
            ),
            const Divider(height: 1),
            Container(
              decoration: BoxDecoration(color: Get.theme.cardColor),
              child: TextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
