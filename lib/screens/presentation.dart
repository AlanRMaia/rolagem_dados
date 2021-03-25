import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/screens/login.dart';
import 'package:rolagem_dados/widget/my_text_button.dart';

class Presentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyTextButton(
                        buttonName: 'Registro',
                        onTap: () {
                          Get.toNamed('signup');
                        },
                        bgColor: Colors.white,
                        textColor: Colors.black87),
                  ),
                  Expanded(
                    child: MyTextButton(
                        buttonName: 'Sign In',
                        onTap: () {
                          Get.toNamed('login');
                        },
                        bgColor: Colors.transparent,
                        textColor: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
