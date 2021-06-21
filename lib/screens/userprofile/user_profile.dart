import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/screens/userprofile/edit_profile.dart';
import 'package:rolagem_dados/widget/button_widget.dart';
import 'package:rolagem_dados/widget/theme/my_themes.dart';
import 'package:rolagem_dados/widget/userprofile/profile.dart';
import 'package:rolagem_dados/widget/userprofile/rating_followers.dart';

class UserProfile extends GetView<AuthController> {
  final _user = UserController.to.user;
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Profile(
            imagePath: _user.image,
            onClicked: () {
              Get.to(() => EditProfile());
            },
          ),
          const SizedBox(height: 24),
          buildName(_user),
          const SizedBox(height: 24),
          RatingFollowers(),
          const SizedBox(height: 48),
          buildAbout(_user),
        ],
      ),
    );
  }
}

Widget buildName(UserModel user) => Column(
      children: [
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildUpgradeButton() => ButtonWidget(
      text: 'Upgrade To PRO',
      onClicked: () {},
    );

Widget buildAbout(UserModel user) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre mim',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            user?.about,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
