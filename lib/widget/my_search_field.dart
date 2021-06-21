import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class MySearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool showButton;
  final VoidCallback voidCallback;
  final Function(String) onSubmited;
  final Object model;

  const MySearchField({
    Key key,
    this.controller,
    this.onChanged,
    this.voidCallback,
    this.showButton,
    this.onSubmited,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              style: kBodyText.copyWith(
                color: Colors.white,
              ),
              controller: controller,
              onSubmitted: (text) {
                onSubmited(text);
              },
              onChanged: onChanged,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'Digite o nome do amigo',
                hintStyle: kBodyText,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.isDarkMode ? Colors.white : Colors.black87,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            height: 59,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.white : Colors.black87,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: IconButton(
              disabledColor:
                  Get.isDarkMode ? Colors.grey[300] : Colors.grey.shade400,
              color: Colors.black,
              onPressed: showButton != false ? voidCallback : null,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
