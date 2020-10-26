import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/chat/chat_screen.dart';
import 'package:rolagem_dados/services/data_base.dart';

class Home extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(initState: (_) async {
          Get.find<UserController>().user =
              await Database().getUser(controller.user.uid);
        }, builder: (_) {
          if (_.user.name != null) {
            return Text('Seja bem vindo ${_.user.name}');
          } else {
            return const CircularProgressIndicator();
          }
        }),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Get.to(ChatScreen());
          },
          child: const Text('Chat'),
        ),
      ),
    );
  }
}
