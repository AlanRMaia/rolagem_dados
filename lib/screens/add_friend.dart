import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/add_friend_controller.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/screens/userprofile/user_profile.dart';
import 'package:rolagem_dados/widget/addfriend/dialog_add_friend.dart';
import 'package:rolagem_dados/widget/my_search_field.dart';
import 'package:rolagem_dados/widget/search_result_list.dart';
import 'package:rolagem_dados/widget/userprofile/dialog_delete_friend.dart';

import 'userprofile/user_friend_profile.dart';

class AddFriend extends GetView<AuthController> {
  final TextEditingController _textController = TextEditingController();
  final AddFriendController _friendController = Get.put(AddFriendController());

  void _seachFriend() {
    AddFriendController.to.resultsFriends(_textController.text);
    _clear();
    AddFriendController.to.isEmpty = !AddFriendController.to.isEmpty;
  }

  void _clear() => _textController.clear();

  void _addFriend(UserModel friendUser) {
    AddFriendController.to.addFriend(friendUser);
  }

  Future<void> _reload() async {
    AddFriendController.to.loadFriends();
  }

  @override
  Widget build(BuildContext context) {
    AddFriendController.to.loadFriends();
    return GestureDetector(
      onTap: () => Get.focusScope.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60,
          title: Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 1, 14),
            child: Obx(
              () => SizedBox(
                height: 50,
                width: Get.width,
                child: MySearchField(
                  theme: Get.isDarkMode,
                  voidCallback: _seachFriend,
                  controller: _textController,
                  showButton: AddFriendController.to.isEmpty,
                  onSubmited: (text) {
                    AddFriendController.to.resultsFriends(text);
                    _clear();
                  },
                  onChanged: (text) {
                    AddFriendController.to.isEmpty = text.isNotEmpty;
                  },
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(1),
              child: AddFriendController.to.obx((state) => RefreshIndicator(
                    onRefresh: _reload,
                    child: ListView.separated(
                        separatorBuilder: (_, ___) => const Divider(),
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onLongPress: () => showDialog(
                              context: context,
                              builder: (context) => DialogDeleteFriend(
                                user: UserController.to.user,
                                friend: state[index],
                              ),
                            ),
                            onTap: () => Get.to(() => UserFriendProfile(),
                                arguments: state[index]),
                            dense: true,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(state[index].image),
                            ),
                            title: Text(
                              state[index].name,
                            ),
                            subtitle: Text(
                              state[index].email,
                            ),
                          );
                        }),
                  )),
            ),
            Obx(() => AddFriendController.to.resultFriends.isNotEmpty
                ? SizedBox(
                    child: ListView.builder(
                        itemCount: AddFriendController.to.resultFriends.length,
                        itemBuilder: (context, index) {
                          return SearchResultList(
                            user: AddFriendController.to.resultFriends[index],
                            onPressed: () =>
                                _friendController.resultFriends.clear(),
                            voidCallback: () async {
                              _addFriend(
                                  AddFriendController.to.resultFriends[index]);
                              AddFriendController.to.resultFriends.clear();
                              await controller.numberOfFriends();
                            },
                            voidCallbackReload: () {
                              _friendController.resultFriends.clear();
                            },
                          );
                        }),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }
}
