import 'package:flutter/material.dart';

import 'Image_avatar_user.dart';

class ImageInicialUser extends StatelessWidget {
  final String assets;
  final String imgUrl;
  final String fileUrl;
  final VoidCallback callbackShowImage;
  final bool isEdit;
  const ImageInicialUser({
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
        child: const ImageAvatarUser());
  }
}
