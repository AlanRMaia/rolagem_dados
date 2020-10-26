import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false; 
  // ignore: unnecessary_getters_setters
  bool get isComposing => _isComposing;
  // ignore: unnecessary_getters_setters
  set isComposing(bool value) => _isComposing = value;

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      //sempre que for diferenciar um tema em uma parte especifica tem que usar o widget Theme(nesse caso o IconTheme)
      data: IconThemeData(color: Get.theme.accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: Get.theme.platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]),
                ),
              )
            : null,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.photo_camera),
              onPressed: () {},
            ),
            Expanded(
                child: TextField(
              decoration:
                  const InputDecoration(hintText: 'Enviar uma mensagem'),
              onChanged: (text) {
                setState(() {
                isComposing= text.isNotEmpty;
                  
                });
              },
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Get.theme.platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      onPressed: isComposing? () {} : null,
                      child: const Text('Enviar'),
                    )
                  : IconButton(
                      onPressed: isComposing? () {} : null,
                      icon: const Icon(Icons.send),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
