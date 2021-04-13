import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';
import 'package:rolagem_dados/services/data_base.dart';

class HomeController extends GetxController with StateMixin<List<RoomModel>> {
  final Database _database;

  HomeController(this._database);

  @override
  void onReady() {
    loadingRooms();
    super.onReady();
  }

  final _imgUrl = false.obs;

  bool get imgUrl => _imgUrl.value;
  set imgUrl(bool value) {
    _imgUrl.value = value;
  }

  final _rooms = <RoomModel>[].obs;

  List<RoomModel> get rooms => _rooms;

  set rooms(List<RoomModel> value) => _rooms.addAll(value);

  void createRoom(String name) {
    _database.roomCreateSubmitted(name);
  }

  Future<void> loadingRooms() async {
    try {
      rooms = await _database.loadRooms();
      change(rooms, status: RxStatus.success());
    } catch (e) {
      print('Erro ao dar loading nas salas $e');
      change([], status: RxStatus.error());
    }
  }
}
