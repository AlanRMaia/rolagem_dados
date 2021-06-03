import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/add_friend_controller.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/screens/userprofile/user_friend_profile.dart';
import 'package:rolagem_dados/widget/addfriend/dialog_add_friend.dart';
import 'package:rolagem_dados/widget/my_search_field.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';

class AddFriend extends GetView<AuthController> {
  final TextEditingController _textController = TextEditingController();
  final AddFriendController _friendController = Get.put(AddFriendController());

  void _seachFriend() {
    AddFriendController.to.allResultsFriends(_textController.text);
    _clear();
    AddFriendController.to.isEmpty = !AddFriendController.to.isEmpty;
  }

  void _clear() => _textController.text = '';

  void _addFriend(Map<String, dynamic> friendUser) {
    AddFriendController.to.addFriend(friendUser);
  }

  void _reload() {
    AddFriendController.to.loadFriends();
  }

  @override
  Widget build(BuildContext context) {
    AddFriendController.to.loadFriends();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: Container(
          margin: const EdgeInsets.fromLTRB(5, 20, 1, 14),
          child: Obx(
            () => MySearchField(
              voidCallback: _seachFriend,
              controller: _textController,
              showButton: AddFriendController.to.isEmpty,
              onSubmited: (text) {
                AddFriendController.to.allResultsFriends(text);
                _clear();
              },
              onChanged: (text) {
                AddFriendController.to.isEmpty = text.isNotEmpty;
              },
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => AddFriendController.to.resultFriends.isNotEmpty
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: AddFriendController.to.resultFriends.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogAddFriend(
                                        data: AddFriendController
                                            .to.resultFriends[index],
                                        voidCallback: () {
                                          _addFriend(AddFriendController
                                              .to.resultFriends[index]);
                                          AddFriendController.to.resultFriends
                                              .clear();
                                        },
                                        voidCallbackReload: () {
                                          _reload();
                                        },
                                      );
                                    });
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    AddFriendController
                                        .to.resultFriends[index]['image']
                                        .toString()),
                              ),
                              title: Text(
                                  AddFriendController
                                      .to.resultFriends[index]['name']
                                      .toString(),
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(
                                  AddFriendController
                                      .to.resultFriends[index]['id']
                                      .toString(),
                                  style: const TextStyle(color: Colors.white)),
                            ) ??
                            const CircularProgressIndicator();
                      }),
                )
              : Container()),
          Flexible(
            child: AddFriendController.to.obx((state) => ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state[index]['image'].toString()),
                    ),
                    title: Text(
                      state[index]['name'].toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(state[index]['id'].toString(),
                        style: const TextStyle(color: Colors.white)),
                  );
                })),
          )
        ],
      ),
    );
  }
}
