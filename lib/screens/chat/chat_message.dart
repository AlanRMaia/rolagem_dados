import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/utils/popmenu/icon_menu.dart';
import 'package:rolagem_dados/utils/popmenu/text_menu.dart';
import 'package:rolagem_dados/widget/chatmessage/dialog_image_delete.dart';
import 'package:rolagem_dados/widget/chatmessage/dialog_text_edit_delete.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatMessage extends GetView<TextComposerController> {
  final Map<String, dynamic> data;
  final bool mine;

  const ChatMessage({this.data, this.mine});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    void _reset() {
      _textController.clear();
    }

    DateTime _ago(Timestamp t) {
      return t.toDate();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!mine)
            Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 3),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        data['senderPhotoUrl'] as String ??
                            "https://firebasestorage.googleapis.com/v0/b/geradordedados-rpg.appspot.com/o/Avatar%2Fuser-icon-vector.jpg?alt=media&token=11126173-cd17-4a38-9b2f-61ab085d39dd",
                        scale: 1),
                  ),
                ),
              ],
            ),
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: mine
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              bottomRight: mine
                                  ? const Radius.circular(0)
                                  : const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: mine
                                  ? const Radius.circular(16)
                                  : const Radius.circular(0),
                            ),
                            color: mine ? Colors.cyan[900] : Colors.blueGrey,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: data['imgUrl'] != null
                              ? DialogImageDelete(data: data)
                              : DialogTextEditDelete(
                                  !mine,
                                  textController: _textController,
                                  data: data,
                                )),
                      Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
