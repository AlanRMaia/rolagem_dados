import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rolagem_dados/widget/Image_avatar.dart';

import '../Image_avatar_preview.dart';

class ImageInicial extends StatelessWidget {
  final String assets;
  final String imgUrl;
  final String fileUrl;
  final VoidCallback callbackShowImage;
  final bool isEdit;
  const ImageInicial({
    Key key,
    this.imgUrl,
    this.callbackShowImage,
    this.isEdit,
    this.fileUrl,
    this.assets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          callbackShowImage();
        },
        child: const ImageAvatar());
  }
}
