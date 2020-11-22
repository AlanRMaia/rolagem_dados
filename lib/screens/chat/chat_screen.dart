import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/chat_screen_controller.dart';
import 'package:rolagem_dados/screens/chat/chat_message.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'text_composer.dart';

class ChatScreen extends StatelessWidget {
  final ChatScreenController _chatScreenController =
      Get.put(ChatScreenController());

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
              child: Obx(() => ListView.builder(
                    reverse: true,
                    itemCount: _chatScreenController.messages.length,
                    itemBuilder: (context, index) {
                      return ChatMessage(_chatScreenController.messages[index]);
                    },
                  )),
            ),
            const Divider(height: 1),
            Container(
              decoration: BoxDecoration(color: Get.theme.cardColor),
              child: TextComposer(),
            )
          ],
        ),
      ),
    );
  }
}
