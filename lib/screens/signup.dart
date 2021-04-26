import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/constants.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/widget/my_password_field.dart';
import 'package:rolagem_dados/widget/my_text_button.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        backwardsCompatibility: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
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
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Register",
                              style: kHeadline,
                            ),
                            const Text(
                              "Create new account to get started.",
                              style: kBodyText2,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              controller: nameController,
                              hintText: 'Name',
                              inputType: TextInputType.name,
                            ),
                            MyTextField(
                              controller: emailController,
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                            ),
                            MyTextField(
                              controller: phoneController,
                              hintText: 'Phone',
                              inputType: TextInputType.phone,
                            ),
                            Expanded(
                              child: Obx(
                                () => MyPasswordField(
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
                              "Already have an account? ",
                              style: kBodyText,
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed('/login'),
                              child: Text(
                                "Sign In",
                                style: kBodyText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => MyTextButton(
                          buttonName: 'Register',
                          isLoading: controller.isLoading,
                          onTap: () {
                            controller.createUser(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text);
                          },
                          bgColor: Colors.white,
                          textColor: Colors.black87,
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
