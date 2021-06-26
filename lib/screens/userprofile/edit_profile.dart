import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/widget/signup/image_preview.dart';
import 'package:rolagem_dados/widget/theme/my_themes.dart';
import 'package:rolagem_dados/widget/userprofile/profile.dart';
import 'package:rolagem_dados/widget/userprofile/textfield.dart';
import 'package:rolagem_dados/widget/widget.dart';

import '../../constants.dart';

class EditProfile extends GetView<AuthController> {
  final _user = UserController.to.user;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: _user.name);
    final TextEditingController emailController =
        TextEditingController(text: _user.email);
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController =
        TextEditingController(text: _user.phone);
    final TextEditingController sobremimController =
        TextEditingController(text: _user.about);

    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Get.focusScope.unfocus(),
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
                      Obx(() => ImagePreview(
                            isEdit: true,
                            callbackShowImage: controller.showImageGallery,
                            imgUrl: controller.imgUrl ?? _user.image,
                          )),
                      // Profile(
                      //   imagePath: _user.image,
                      //   isEdit: true,
                      //   onClicked: () async {
                      //     await controller.showImageGallery();
                      //     _user.image = controller.imgUrl;
                      //   },
                      // ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Nome completo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            MyTextField(
                              borderColorFocus: Get.isDarkMode
                                  ? MyThemes.darkTheme.colorScheme.primary
                                  : MyThemes.lightTheme.colorScheme.primary,
                              controller: nameController,
                              hintText: 'Nome',
                              inputType: TextInputType.name,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            MyTextField(
                              borderColorFocus: Get.isDarkMode
                                  ? MyThemes.darkTheme.colorScheme.primary
                                  : MyThemes.lightTheme.colorScheme.primary,
                              controller: emailController,
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Telefone',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            MyTextField(
                              borderColorFocus: Get.isDarkMode
                                  ? MyThemes.darkTheme.colorScheme.primary
                                  : MyThemes.lightTheme.colorScheme.primary,
                              controller: phoneController,
                              hintText: 'Telefone',
                              inputType: TextInputType.phone,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Sobre mim',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 2),
                            MyTextField(
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
                            isLoading: controller.isLoading,
                            onTap: () {
                              controller.editUser(
                                uid: _user.id,
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                about: sobremimController.text,
                              );
                              Get.back();
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
    //   body: ListView(
    //     padding: const EdgeInsets.symmetric(horizontal: 32),
    //     physics: const BouncingScrollPhysics(),
    //     children: [
    //       Profile(
    //         imagePath: _user.image,
    //         isEdit: true,
    //         onClicked: () async {
    //           await controller.showImageGallery();
    //           _user.image = controller.imgUrl;
    //         },
    //       ),
    //       const SizedBox(height: 24),
    //       TextfieldWidget(
    //         label: 'Nome completo',
    //         text: _user.name,
    //         onChanged: (name) {},
    //       ),
    //       const SizedBox(height: 24),
    //       TextfieldWidget(
    //         label: 'Email',
    //         text: _user.email,
    //         onChanged: (email) {},
    //       ),
    //       const SizedBox(height: 24),
    //       TextfieldWidget(
    //         label: 'Sobre mim',
    //         text: _user.about,
    //         maxLines: 5,
    //         onChanged: (about) {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
