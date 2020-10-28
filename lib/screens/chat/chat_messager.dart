import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> data;

 const ChatMessage(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data['senderPhotoUrl'] as String),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['senderName'] as String,
                  style: Get.textTheme.bodyText1,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: data['imgUrl'] != null ?
                  Image.network(data['imgUrl'] as String, width: 250, ):
                  Text(data['text'] as String),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
