import 'package:flutter/material.dart';

import '../constants.dart';

class MySearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool showButton;
  final VoidCallback voidCallback;
  final Function(String) onSubmited;
  final Object model;
  final bool theme;

  const MySearchField({
    Key key,
    this.controller,
    this.onChanged,
    this.voidCallback,
    this.showButton,
    this.onSubmited,
    this.model,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              style: kBodyText.copyWith(),
              controller: controller,
              onSubmitted: (text) {
                onSubmited(text);
              },
              onChanged: onChanged,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Digite o email do amigo',
                hintStyle: kBodyText,
                enabledBorder: const OutlineInputBorder(
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
                    color: theme ? Colors.white : Colors.black87,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            height: 58.5,
            decoration: BoxDecoration(
              color: theme ? Colors.white : Colors.black87,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: IconButton(
              disabledColor: Colors.grey[300],
              color: theme == true ? Colors.black : Colors.white,
              onPressed: voidCallback,
              icon: Icon(
                Icons.search,
                color: theme != false ? Colors.black : Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
