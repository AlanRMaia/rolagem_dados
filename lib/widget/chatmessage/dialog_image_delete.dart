import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rolagem_dados/controllers/text_composer_controller.dart';
import 'package:rolagem_dados/screens/file_view.dart';

class DialogImageDelete extends GetView<TextComposerController> {
  final Map<String, dynamic> data;
  final bool mine;

  const DialogImageDelete({@required this.mine, Key key, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _ago(Timestamp t) {
      return t.toDate().toLocal();
    }

    return GestureDetector(
        onTap: () {
          Get.to(() => FileView(), arguments: data);
        },
        onLongPress: mine
            ? () {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: 100,
                                        height: 80,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            data['fileUrl'] as String,
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
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                            onPressed: () async {
                                              await controller
                                                  .documentsDownload(
                                                      data['fileUrl']
                                                          .toString(),
                                                      data['fileName']
                                                          .toString());
                                              controller.isLoading = true;
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.cancel_sharp,
                                              color: Colors.black87,
                                            ),
                                            label: const Text(
                                              'Download',
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
              }
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: data['type'] == 'pdf'
                    ? Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.picture_as_pdf_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              data['fileName'].toString(),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      )
                    : Image.network(
                        data['fileUrl'] as String,
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
