import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/screens/chat/chat_messager.dart';
import 'package:rolagem_dados/services/data_base.dart';

import 'text_composer.dart';

class ChatScreen extends StatelessWidget {
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
              child: GetBuilder<Database>( 
                init: Database(),               
                builder: (database){                  
                  return ListView.builder(
                    itemCount: database.messages.length,
                    itemBuilder: (context, index){                    
                      return ChatMessage(database.messages[index]);
                    },

                  );
                }
              )
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
