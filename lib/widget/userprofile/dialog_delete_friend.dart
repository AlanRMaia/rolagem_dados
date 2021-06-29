import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/add_friend_controller.dart';
import 'package:rolagem_dados/models/user.dart';

class DialogDeleteFriend extends GetView<AddFriendController> {
  final UserModel friend;
  final UserModel user;
  const DialogDeleteFriend({
    @required this.friend,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          friend.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                          onPressed: () async {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.cancel_sharp,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          )),
                      OutlinedButton.icon(
                        onPressed: () {
                          controller.deleteFriend(user, friend);
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Sair',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
