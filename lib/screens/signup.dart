import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/constants.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/utils/validators.dart';
import 'package:rolagem_dados/widget/Image_avatar.dart';
import 'package:rolagem_dados/widget/Image_avatar_preview.dart';
import 'package:rolagem_dados/widget/my_password_field.dart';
import 'package:rolagem_dados/widget/my_text_button.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';
import 'package:rolagem_dados/widget/my_text_form_field.dart';
import 'package:rolagem_dados/widget/signup/image_inicial.dart';
import 'package:rolagem_dados/widget/signup/image_preview.dart';
import 'package:validatorless/validatorless.dart';

class SignUp extends GetWidget<AuthController> {
  final _formKey = GlobalKey<FormState>();
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
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Obx(() => controller.imgUrl == ''
                          ? ImageInicial(
                              callbackShowImage: controller.showImageGallery,
                            )
                          : ImagePreview(
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                key: const ValueKey('Nome'),
                                label: 'Nome',
                                validator:
                                    Validatorless.required('Nome obrigatório'),
                                borderColorFocus: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                controller: nameController,
                                inputType: TextInputType.name,
                              ),
                              MyTextFormField(
                                key: const ValueKey('Email'),
                                label: 'Email',
                                validator: Validatorless.multiple([
                                  Validatorless.required('Email obrigatório'),
                                  Validatorless.email('E-mail inválido'),
                                ]),
                                borderColorFocus: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                controller: emailController,
                                inputType: TextInputType.emailAddress,
                              ),
                              MyTextFormField(
                                key: const ValueKey('Telefone'),
                                label: 'Telefone',
                                validator: Validatorless.multiple([
                                  Validatorless.max(
                                      11, 'Número máximo de 11 digitos'),
                                  Validatorless.required(
                                      'Número de telefone obrigatório'),
                                ]),
                                borderColorFocus: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                controller: phoneController,
                                inputType: TextInputType.phone,
                              ),
                              Expanded(
                                child: Obx(
                                  () => MyPasswordField(
                                    key: const ValueKey('senha'),
                                    label: 'Password',
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'senha obrigatória'),
                                      Validatorless.min(
                                          6, 'Necessário o mínimo de 6 digitos')
                                    ]),
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
                              Expanded(
                                child: Obx(
                                  () => MyPasswordField(
                                    key: const ValueKey('confirma senha'),
                                    label: 'Confirme Password',
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'senha obrigatória'),
                                      Validatorless.min(6,
                                          'Necessário o mínimo de 6 digitos'),
                                      Validators.compare(passwordController,
                                          'Senhas não conferem')
                                    ]),
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
                        () => Container(
                          child: MyTextButton(
                            loadingColor:
                                Get.isDarkMode ? Colors.black : Colors.white,
                            buttonName: 'Cadastrar',
                            isLoading: controller.isLoading,
                            onTap: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;

                              if (formValid) {
                                controller.createUser(
                                  nameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  phoneController.text.trim(),
                                  controller.imgUrl,
                                );
                              }
                            },
                            bgColor:
                                Get.isDarkMode ? Colors.white : Colors.black,
                            textColor:
                                Get.isDarkMode ? Colors.black : Colors.white,
                          ),
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
