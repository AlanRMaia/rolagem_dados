import 'dart:io';

import 'package:flutter/material.dart';

class ImageAvatarPreview extends StatelessWidget {
  final File arquivo;
  final Icon icon;

  const ImageAvatarPreview({Key key, this.arquivo, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: arquivo != null
                  ? Image.file(
                      arquivo,
                      fit: BoxFit.cover,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[100], child: icon)),
        ),
      ),
    );
  }
}
