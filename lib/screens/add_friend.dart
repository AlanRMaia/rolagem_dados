import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/add_friend_controller.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/screens/userprofile/user_friend_profile.dart';
import 'package:rolagem_dados/widget/my_search_field.dart';
import 'package:rolagem_dados/widget/my_text_field.dart';

class AddFriend extends GetView<AuthController> {
  final TextEditingController _textController = TextEditingController();
  final AddFriendController _friendController = Get.put(AddFriendController());

  void _seachFriend() {
    _friendController.allResultsFriends(_textController.text);
    _clear();
  }

  void _clear() => _textController.text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: Container(
          margin: const EdgeInsets.fromLTRB(5, 20, 1, 14),
          child: Obx(() => MySearchField(
                voidCallback: _seachFriend,
                controller: _textController,
                showButton: _friendController.isEmpty,
                onSubmited: (text) {
                  _friendController.allResultsFriends(text);
                  _clear();
                },
                onChanged: (text) {
                  _friendController.isEmpty = text.isNotEmpty;
                },
              )),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => _friendController.resultFriends.isNotEmpty
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: _friendController.resultFriends.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                              onTap: () {
                                Get.to(() => UserFriendProfile(),
                                    arguments:
                                        _friendController.resultFriends[index]);
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(_friendController
                                    .resultFriends[index]['image'] as String),
                              ),
                              title: Text(_friendController.resultFriends[index]
                                  ['name'] as String),
                              subtitle: Text(_friendController
                                  .resultFriends[index]['id'] as String),
                            ) ??
                            const CircularProgressIndicator();
                      }),
                )
              : Container()),
          Flexible(
            child: _friendController.obx((state) => ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(state[index]['image'] as String),
                      ),
                      title: Text(state[index]['name'] as String),
                      subtitle: Text(state[index]['name'] as String),
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}
