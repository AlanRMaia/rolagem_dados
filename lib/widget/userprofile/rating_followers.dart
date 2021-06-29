import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rolagem_dados/controllers/auth_controller.dart';

class RatingFollowers extends GetView<AuthController> {
  final int friends;
  final int rooms;
  const RatingFollowers({
    @required this.friends,
    @required this.rooms,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context, '4.8', 'Curtidas'),
        buildDivider(),
        buildButton(context, friends.toString(), 'Amigos'),
        buildDivider(),
        buildButton(context, rooms.toString(), 'Salas'),
      ],
    );
  }

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
