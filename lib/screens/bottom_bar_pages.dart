import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/bottom_bar_pages_controller.dart';
import 'package:rolagem_dados/screens/userprofile/user_profile.dart';

import 'add_friend.dart';
import 'home.dart';
import 'persons.dart';

class BottomBarPages extends GetView<AuthController> {
  final BottomBarPagesController bottomController = BottomBarPagesController();

  final List<Widget> _pages = [Home(), UserProfile(), AddFriend(), Persons()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages.elementAt(bottomController.indexTab)),
      bottomNavigationBar: Obx(() => MoltenBottomNavigationBar(
            selectedIndex: bottomController.indexTab,
            onTabChange: (clickedIndex) {
              bottomController.indexTab = clickedIndex;
            },
            domeCircleColor: Colors.black87,
            tabs: [
              MoltenTab(
                icon: const Icon(Icons.home),
                selectedColor: Colors.white,
                unselectedColor: Colors.grey,
              ),
              MoltenTab(
                icon: const Icon(Icons.person),
                selectedColor: Colors.white,
                unselectedColor: Colors.grey,
              ),
              MoltenTab(
                icon: const Icon(Icons.person_add_alt_1_rounded),
                selectedColor: Colors.white,
                unselectedColor: Colors.grey,
              ),
              MoltenTab(
                icon: const Icon(Icons.article_outlined),
                selectedColor: Colors.white,
                unselectedColor: Colors.grey,
              ),
            ],
          )),
    );
  }
}
