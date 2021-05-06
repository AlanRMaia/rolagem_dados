import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';

import '../my_text_field.dart';

class DialogImageDelete extends GetView<TextComposerController> {
  final Map<String, dynamic> data;

  const DialogImageDelete({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _ago(Timestamp t) {
      return t.toDate().toLocal();
    }

    return GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: 100,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      data['imgUrl'] as String,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      controller.deleteSubmited(
                                          data['id'] as String,
                                          data['idRoom'] as String);
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      'Excluir',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.cancel_sharp,
                                        color: Colors.black87,
                                      ),
                                      label: const Text(
                                        'Cancelar',
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  data['imgUrl'] as String,
                  width: 250,
                ),
              ),
            ),
            Text(
              DateFormat('Hm', 'en_US').format(
                _ago(data['time'] as Timestamp),
              ),
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 8,
              ),
            ),
          ],
        ));
  }
}
