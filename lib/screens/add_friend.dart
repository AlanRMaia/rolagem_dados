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

  void _reload() {
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
          toolbarHeight: 70,
          title: Container(
            margin: const EdgeInsets.fromLTRB(5, 20, 1, 14),
            child: Obx(
              () => SizedBox(
                height: 50,
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
              child: AddFriendController.to.obx((state) => ListView.separated(
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
                  })),
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
                              _reload();
                            },
                          );
                          // return Container(
                          //   margin: const EdgeInsets.only(
                          //       top: 5, left: 40, right: 40),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(50),
                          //     color: Colors.white,
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.8),
                          //         blurRadius: 4,
                          //         spreadRadius: 1,
                          //         offset: const Offset(
                          //             7, 7), // shadow direction: bottom right
                          //       )
                          //     ],
                          //   ),
                          //   child: ListTile(
                          //         onTap: () {
                          //           showDialog(
                          //               context: context,
                          //               builder: (context) {
                          //                 return DialogAddFriend(
                          //                   data: AddFriendController
                          //                       .to.resultFriends[index],
                          //                   voidCallback: () {
                          //                     _addFriend(AddFriendController
                          //                         .to.resultFriends[index]);
                          //                     AddFriendController
                          //                         .to.resultFriends
                          //                         .clear();
                          //                   },
                          //                   voidCallbackReload: () {
                          //                     _friendController.resultFriends
                          //                         .clear();
                          //                     _reload();
                          //                   },
                          //                 );
                          //               });
                          //         },
                          //         leading: CircleAvatar(
                          //           backgroundImage: NetworkImage(
                          //               AddFriendController
                          //                   .to.resultFriends[index]['image']
                          //                   .toString()),
                          //         ),
                          //         title: Text(
                          //             AddFriendController
                          //                 .to.resultFriends[index]['name']
                          //                 .toString(),
                          //             style:
                          //                 const TextStyle(color: Colors.black)),
                          //         subtitle: Text(
                          //             AddFriendController
                          //                 .to.resultFriends[index]['id']
                          //                 .toString(),
                          //             style:
                          //                 const TextStyle(color: Colors.black)),
                          //         trailing: IconButton(
                          //           onPressed: () {
                          //             _friendController.resultFriends.clear();
                          //           },
                          //           icon: const Icon(
                          //             Icons.close,
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          //         dense: true,
                          //       ) ??
                          //       const CircularProgressIndicator(),
                          // );
                        }),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }
}
