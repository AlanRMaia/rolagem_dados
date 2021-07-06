import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/screens/chat/chat_message.dart';
import 'package:rolagem_dados/screens/chat/chat_screen.dart';
import 'package:rolagem_dados/screens/presentation.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/home/dialog_room_create.dart';
import 'package:rolagem_dados/widget/homePage/dialog_exit_room.dart';

class Home extends GetView<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final HomeController _homeController = Get.put(HomeController(Database()));
  // final AuthController controller = Get.put(AuthController(UserController()));

  final users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            controller.signOut();
            Get.offAll(Presentation());
          },
          tooltip: 'Sair do aplicativo',
        ),
        title: GetX<UserController>(
          initState: (_) async {
            Get.find<UserController>().user =
                await Database().getUser(controller.user.uid);
            await controller.numberOfRooms();
            await controller.numberOfFriends();
            _homeController?.loadRooms(UserController.to.user.id);
          },
          builder: (_) {
            if (_.user.name != null) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_.user.image),
                ),
                title: Text(
                  _.user.name,
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Produrar sala',
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: _homeController.obx(
                  (state) => RefreshIndicator(
                    onRefresh: () async {
                      _homeController.loadRooms(UserController.to.user.id);
                    },
                    child: ListView.builder(
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          // users.addAll(state[index].usuarios);
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(state[index].imgUrl),
                                          fit: BoxFit.fitWidth)),
                                  child: ListTile(
                                    onLongPress: () => showDialog(
                                      context: context,
                                      builder: (context) => DialogExitRoom(
                                        room: state[index],
                                        user: UserController.to.user,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          state[index].admin.image),
                                    ),
                                    isThreeLine: true,
                                    dense: true,
                                    title: Text(state[index].name),
                                    subtitle: Text(state[index].id),
                                    autofocus: true,
                                    onTap: () => Get.toNamed('/chatscreen',
                                        arguments: state[index]),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                      'Administrador: ${state[index].admin.name}'),
                                ),
                                if (state[index].usuarios.isNotEmpty)
                                  Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ExpansionTile(
                                        title: const Text('Participantes'),
                                        children: state[index]
                                            .usuarios
                                            .map((user) => ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            user.image),
                                                  ),
                                                  title: Text(user.name),
                                                ))
                                            .toList(),
                                      ))
                                else
                                  Container(),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return DialogRoomCreate(
                controller: _homeController,
                textController: nameController,
                controllerAuth: controller,
              );
            }),
        tooltip: 'Adicionar uma nova sala',
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class BasicTileWidget extends StatelessWidget {
  final List<UserModel> users;
  const BasicTileWidget({
    Key key,
    this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Participastes'),
      children: users
          .map((user) => ListTile(
                leading:
                    CircleAvatar(backgroundImage: NetworkImage(user.image)),
                title: Text(user.name),
              ))
          .toList(),
    );
  }
}
