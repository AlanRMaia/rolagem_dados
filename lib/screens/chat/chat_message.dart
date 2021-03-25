import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool mine;

  const ChatMessage(this.data, this.mine);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !mine
              ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      data['senderPhotoUrl'] as String ??
                          "https://firebasestorage.googleapis.com/v0/b/geradordedados-rpg.appspot.com/o/Avatar%2Fuser-icon-vector.jpg?alt=media&token=11126173-cd17-4a38-9b2f-61ab085d39dd",
                    ),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  data['senderName'] as String,
                  style: Get.textTheme.bodyText1,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: data['imgUrl'] != null
                      ? Image.network(
                          data['imgUrl'] as String,
                          width: 250,
                        )
                      : Text(
                          data['text'] as String,
                          textAlign: mine ? TextAlign.end : TextAlign.start,
                          style: Get.textTheme.bodyText2,
                        ),
                ),
              ],
            ),
          ),
          mine
              ? Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      data['senderPhotoUrl'] as String ??
                          "https://firebasestorage.googleapis.com/v0/b/geradordedados-rpg.appspot.com/o/Avatar%2Fuser-icon-vector.jpg?alt=media&token=11126173-cd17-4a38-9b2f-61ab085d39dd",
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
