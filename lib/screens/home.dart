import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/home_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/main.dart';
import 'package:rolagem_dados/screens/presentation.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/widget/home/dialog_room_create.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController nameController = TextEditingController();
  final HomeController _homeController = Get.put(HomeController(Database()));

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
            _homeController.loadRooms(UserController.to.user.id);
          },
          builder: (_) {
            if (_.user.name != null) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_.user.image),
                ),
                title: Text(
                  _.user.name,
                  style: const TextStyle(color: Colors.white),
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
                  (state) => ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state[index].imgUrl),
                            ),
                            title: Text(state[index].name),
                            subtitle: Text(state[index].admUserId),
                            autofocus: true,
                            onTap: () => Get.toNamed('/chatscreen',
                                arguments: state[index]),
                          ),
                        );
                      }),
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
