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

class UserFriendProfile extends GetView<AuthController> {
  final _user = Get.arguments as UserModel;

  @override
  Widget build(BuildContext context) {
    controller.numberOfFriendsFriend(_user);
    controller.numberOfRoomsFriend(_user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Profile(
            imagePath: _user.image,
            onClicked: null,
            isEdit: true,
          ),
          const SizedBox(height: 24),
          buildName(_user),
          const SizedBox(height: 24),
          Obx(() => RatingFollowers(
              friends: controller.myFriendsFriend,
              rooms: controller.myRoomsFriend)),
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
