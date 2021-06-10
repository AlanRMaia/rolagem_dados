import 'dart:io';

import 'package:flutter/material.dart';

import '../Image_avatar_preview.dart';

class ImagePreview extends StatelessWidget {
  final String imgUrl;
  final VoidCallback callbackShowImage;
  const ImagePreview({
    Key key,
    this.imgUrl,
    this.callbackShowImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          callbackShowImage();
        },
        child: imgUrl != ''
            ? ImageAvatarPreview(arquivo: File(imgUrl))
            : const ImageAvatarPreview(
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.black87,
                  size: 60,
                ),
              ));
  }
}
