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
              backgroundImage: NetworkImage(data['senderPhotoUrl'] as String ??
                  "https://www.google.com/imgres?imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F000%2F550%2F731%2Fnon_2x%2Fuser-icon-vector.jpg&imgrefurl=https%3A%2F%2Fpt.vecteezy.com%2Farte-vetorial%2F550731-vetor-de-icone-de-usuario&tbnid=AxU_EbYduWAyeM&vet=12ahUKEwjR2dyrsZTtAhVuM7kGHU03CMgQMygBegUIARDMAQ..i&docid=9cw9cSsy0MoyRM&w=490&h=490&q=imagem%20usu%C3%A1rio&ved=2ahUKEwjR2dyrsZTtAhVuM7kGHU03CMgQMygBegUIARDMAQ"),
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
                  child: data['imgUrl'] != null
                      ? Image.network(
                          data['imgUrl'] as String,
                          width: 250,
                        )
                      : Text(data['text'] as String),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
