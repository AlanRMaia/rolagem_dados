import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';
import 'package:rolagem_dados/widget/widget.dart';
import 'package:validatorless/validatorless.dart';

import '../constants.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          icon: Image(
            width: 24,
            image: const Svg('assets/images/back_arrow.svg'),
            color: Get.isDarkMode ? Colors.white : Colors.black87,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                            child: Column(
                          children: [
                            Text(
                              "Seja bem vindo",
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Estávamos à sua espera",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            MyTextField(
                              label: 'Email',
                              validator: Validatorless.multiple([
                                Validatorless.required('Email obrigatório'),
                                Validatorless.email(
                                    'Email com formato inválido'),
                              ]),
                              borderColorFocus:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              controller: emailController,
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                            ),
                            Expanded(
                              child: Obx(() => MyPasswordField(
                                    label: 'Password',
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Senha obrigatória'),
                                      Validatorless.min(6,
                                          'Senha deve conter no mínimo 6 caractéres')
                                    ]),
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
                                final _formValidator =
                                    _formKey.currentState.validate() ?? false;

                                if (_formValidator) {
                                  controller.login(emailController.text,
                                      passwordController.text);
                                }
                              },
                              loadingColor: Get.isDarkMode
                                  ? Colors.black87
                                  : Colors.white,
                              bgColor:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              textColor: Get.isDarkMode
                                  ? Colors.black87
                                  : Colors.white),
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
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
