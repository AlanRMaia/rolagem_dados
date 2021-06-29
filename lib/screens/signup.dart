import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/constants.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/widget/Image_avatar_preview.dart';
import 'package:rolagem_dados/widget/my_password_field.dart';
import 'package:rolagem_dados/widget/my_text_button.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';
import 'package:rolagem_dados/widget/signup/image_preview.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        backwardsCompatibility: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.isLoading = false;
            controller.imgUrl = '';
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
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Obx(() => ImagePreview(
                            isEdit: true,
                            callbackShowImage: controller.showImageGallery,
                            fileUrl: controller.imgUrl,
                          )),
                      // OutlinedButton.icon(
                      //   style: ElevatedButton.styleFrom(
                      //     side: const BorderSide(color: Colors.grey),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      //   icon: const Icon(
                      //     Icons.attach_file,
                      //     color: Colors.white,
                      //   ),
                      //   label: const Text(
                      //     'Galeria',
                      //     style: TextStyle(color: Colors.grey),
                      //   ),
                      //   onPressed: () => controller.showImageGallery(),
                      // ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              borderColorFocus:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              controller: nameController,
                              hintText: 'Nome',
                              inputType: TextInputType.name,
                            ),
                            MyTextField(
                              borderColorFocus:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              controller: emailController,
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                            ),
                            MyTextField(
                              borderColorFocus:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              controller: phoneController,
                              hintText: 'Telefone',
                              inputType: TextInputType.phone,
                            ),
                            Expanded(
                              child: Obx(
                                () => MyPasswordField(
                                  borderColorFocus: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  controller: passwordController,
                                  onChanged: (value) {},
                                  showPassword: controller.isPassWordVisible,
                                  changeShowPassword: () {
                                    controller.isPassWordVisible =
                                        !controller.isPassWordVisible;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 50)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Já tem uma conta? ",
                              style: kBodyText,
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed('/login'),
                              child: Text(
                                "Entrar",
                                style: kBodyText.copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => MyTextButton(
                          buttonName: 'Cadastrar',
                          isLoading: controller.isLoading,
                          onTap: () {
                            controller.createUser(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              phoneController.text,
                              controller.imgUrl,
                            );
                          },
                          bgColor: Get.isDarkMode ? Colors.white : Colors.black,
                          textColor:
                              Get.isDarkMode ? Colors.black87 : Colors.white,
                        ),
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
