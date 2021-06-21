import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';
import 'package:rolagem_dados/widget/widget.dart';

import '../constants.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.isLoading = false;
          },
          icon: const Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Get.focusScope.unfocus(),
          child: CustomScrollView(
            reverse: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                          child: Column(
                        children: [
                          Text(
                            "Seja bem vindo",
                            style: kHeadline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Estávamos à sua espera",
                            style: kBodyText2,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          MyTextField(
                            borderColorFocus:
                                Get.isDarkMode ? Colors.white : Colors.black,
                            controller: emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          Expanded(
                            child: Obx(() => MyPasswordField(
                                  borderColorFocus: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  controller: passwordController,
                                  showPassword: controller.isPassWordVisible,
                                  changeShowPassword: () =>
                                      controller.isPassWordVisible =
                                          !controller.isPassWordVisible,
                                )),
                          )
                        ],
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Não possui uma conta? ",
                            style: kBodyText,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/signup');
                            },
                            child: Text(
                              'Registrar',
                              style: kBodyText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => MyTextButton(
                          isLoading: controller.isLoading,
                          buttonName: 'Entrar',
                          onTap: () {
                            controller.login(
                                emailController.text, passwordController.text);
                          },
                          bgColor: Get.isDarkMode ? Colors.white : Colors.black,
                          textColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
