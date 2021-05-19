import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rolagem_dados/models/user.dart';

class UserFriendProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFriend = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        toolbarHeight: 200,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage(userFriend['image'] as String, scale: 1),
            ),
            const SizedBox(height: 10),
            Text(
              userFriend['name'] as String,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(userFriend['email'] as String,
                style: TextStyle(
                  color: Colors.white,
                )),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
