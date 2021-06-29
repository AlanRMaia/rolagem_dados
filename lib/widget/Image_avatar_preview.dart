import 'dart:io';

import 'package:flutter/material.dart';

class ImageAvatarPreview extends StatelessWidget {
  final File arquivo;
  final String imgUrl;
  final Icon icon;
  final VoidCallback onClicked;
  final bool isEdit;

  const ImageAvatarPreview(
      {Key key,
      this.arquivo,
      this.icon,
      this.onClicked,
      this.isEdit,
      this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: arquivo != null
                      ? Image.file(arquivo, fit: BoxFit.cover)
                      : Image.network(imgUrl, fit: BoxFit.cover)),
            ),
            Positioned(
                bottom: 0,
                right: 4,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(3),
                    child: ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: color,
                        child: Icon(
                          isEdit ? Icons.add_a_photo : Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// child: Stack(
//   children: [
//     ClipOval(
//         child: Container(
//       width: 128,
//       height: 128,
//       child: InkWell(
//         child: Image.file(
//           arquivo,
//           fit: BoxFit.cover,
//         ),
//         onTap: onClicked,
//       ),
//     )),
//     Positioned(
//         bottom: 0,
//         right: 4,
//         child: ClipOval(
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(3),
//             child: ClipOval(
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 color: color,
//                 child: Icon(
//                   isEdit ? Icons.add_a_photo : Icons.edit,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ),
//         )),
//   ],
// ),
