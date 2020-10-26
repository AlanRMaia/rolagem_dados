import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
             Container(
               decoration: BoxDecoration(
                 color: Get.theme.cardColor 
               ),
               child: TextComposer(),
             )
           ],

         ),
      ),
      
    );
  }
}