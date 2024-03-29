import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/bottom_bar_pages.dart';
import 'package:rolagem_dados/widget/image_inicial_user.dart';
import 'package:rolagem_dados/widget/signup/image_inicial.dart';
import 'package:rolagem_dados/widget/signup/image_preview.dart';
import 'package:rolagem_dados/widget/theme/my_themes.dart';
import 'package:rolagem_dados/widget/widget.dart';
import 'package:validatorless/validatorless.dart';

class EditProfile extends GetView<AuthController> {
  final _user = UserController.to.user;
  final TextEditingController nameController =
      TextEditingController(text: UserController.to.user.name);
  final TextEditingController phoneController =
      TextEditingController(text: UserController.to.user.phone);
  final TextEditingController sobremimController =
      TextEditingController(text: UserController.to.user.about);

  @override
  Widget build(BuildContext context) {
    // final TextEditingController nameController =
    //     TextEditingController(text: _user.name);
    // final TextEditingController emailController =
    //     TextEditingController(text: _user.email);
    // final TextEditingController phoneController =
    //     TextEditingController(text: _user.phone);
    // final TextEditingController sobremimController =
    //     TextEditingController(text: _user.about);
    // final _formEditKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              controller.imgFile = null;
              controller.imgUrl = '';
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () async {
                Get.changeTheme(
                    Get.isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme);
                controller.isDarkMode = Get.isDarkMode;
                await controller.changeDarkMode(darkMode: Get.isDarkMode);
              },
              icon: !controller.isDarkMode
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => Get.focusScope.unfocus(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      Obx(() => controller.imgUrl == ''
                          ? ImageInicialUser(
                              callbackShowImage: controller.showImageGallery,
                            )
                          : ImagePreview(
                              isEdit: true,
                              callbackShowImage: controller.showImageGallery,
                              fileUrl: controller.imgUrl,
                            )),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              key: const ValueKey('Nome'),
                              label: 'Nome',
                              borderColorFocus: Get.isDarkMode
                                  ? MyThemes.darkTheme.colorScheme.primary
                                  : MyThemes.lightTheme.colorScheme.primary,
                              controller: nameController,
                              inputType: TextInputType.name,
                            ),
                            const SizedBox(height: 4),
                            // MyTextField(
                            //   label: 'Email',
                            //   validator: Validatorless.multiple([
                            //     Validatorless.email('Email inválido'),
                            //     Validatorless.required('Email obrigatório')
                            //   ]),
                            //   borderColorFocus: Get.isDarkMode
                            //       ? MyThemes.darkTheme.colorScheme.primary
                            //       : MyThemes.lightTheme.colorScheme.primary,
                            //   controller: emailController,
                            //   inputType: TextInputType.emailAddress,
                            // ),
                            // const SizedBox(height: 4),
                            MyTextField(
                              key: const ValueKey('Telefone'),
                              label: 'Telefone',
                              borderColorFocus: Get.isDarkMode
                                  ? MyThemes.darkTheme.colorScheme.primary
                                  : MyThemes.lightTheme.colorScheme.primary,
                              controller: phoneController,
                              inputType: TextInputType.name,
                            ),
                            const SizedBox(height: 4),
                            MyTextField(
                              key: const ValueKey('Sobre mim'),
                              label: 'Sobre mim',
                              borderColorFocus: Get.isDarkMode
                                  ? MyThemes.darkTheme.colorScheme.primary
                                  : MyThemes.lightTheme.colorScheme.primary,
                              maxLines: 5,
                              controller: sobremimController,
                              hintText: 'Descreva a sua biografia',
                              inputType: TextInputType.multiline,
                            ),
                            const SizedBox(height: 50)
                          ],
                        ),
                      ),
                      Obx(
                        () => MyTextButton(
                            buttonName: 'Salvar',
                            loadingColor: Colors.white,
                            isLoading: controller.isLoading,
                            onTap: () {
                              // final formValidator =
                              //     _formEditKey.currentState.validate() ?? false;

                              if (nameController.text == '') {
                                Get.snackbar('Campo nome', 'Campo obrigatório');
                                return null;
                              }
                              if (phoneController.text == '') {
                                Get.snackbar(
                                    'Campo telefone', 'Campo obrigatório');
                                return null;
                              }

                              if (phoneController.text.length < 11) {
                                Get.snackbar('Campo telefone',
                                    'Campo deve conter no mínimo 11 caracteres');
                                return null;
                              }
                              controller.editUser(
                                uid: _user.id,
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                                about: sobremimController.text.trim(),
                              );

                              Timer(const Duration(seconds: 3), () {
                                controller.isLoading = false;
                                Get.off(() => BottomBarPages());
                                controller.imgFile = null;
                              });

                              // if (formValidator) {

                              // }

                              //print('File: ${controller.imgFile.path}');
                            },
                            bgColor: Get.isDarkMode
                                ? MyThemes.darkTheme.colorScheme.primary
                                : MyThemes.lightTheme.colorScheme.primary,
                            textColor: Colors.white),
                      ),
                      const SizedBox(height: 10)
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
