import 'package:flutter/material.dart';
import 'package:rolagem_dados/controllers/add_friend_controller.dart';
import 'package:rolagem_dados/models/user.dart';

import 'addfriend/dialog_add_friend.dart';

class SearchChatResultList extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback voidCallback;
  final VoidCallback voidCallbackReload;
  final VoidCallback onPressed;
  final UserModel user;
  const SearchChatResultList(
      {Key key,
      this.data,
      this.voidCallback,
      this.voidCallbackReload,
      this.onPressed,
      this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 40, right: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(2, 2), // shadow direction: bottom right
              )
            ],
          ),
          child: ListTile(
                enableFeedback: true,
                onTap: () {
                  voidCallback();
                  voidCallbackReload();
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return DialogAddFriend(
                  //         user: user,
                  //         data: data,
                  //         voidCallback: voidCallback,
                  //         //() {

                  //         //   _addFriend(AddFriendController
                  //         //       .to.resultFriends[index]);
                  //         //   AddFriendController
                  //         //       .to.resultFriends
                  //         //       .clear();
                  //         // },
                  //         voidCallbackReload: voidCallbackReload,
                  //         //() {
                  //         //   _friendController.resultFriends
                  //         //       .clear();
                  //         //   _reload();
                  //         // },
                  //       );
                  //     });
                },
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(user?.image ?? data['image'].toString()
                          // AddFriendController
                          //     .to.resultFriends[index]['image']
                          //     .toString()

                          ),
                ),
                title: Text(user?.name ?? data['name'].toString(),
                    // AddFriendController
                    //     .to.resultFriends[index]['name']
                    //     .toString(),
                    style: const TextStyle(color: Colors.black)),
                subtitle: Text(user?.email ?? data['email'].toString(),
                    // AddFriendController
                    //     .to.resultFriends[index]['id']
                    //     .toString(),
                    style: const TextStyle(color: Colors.black)),
                trailing: IconButton(
                  onPressed: onPressed,
                  //() {

                  // _friendController.resultFriends.clear();
                  // },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                dense: true,
              ) ??
              const CircularProgressIndicator(),
        ));
  }
}
