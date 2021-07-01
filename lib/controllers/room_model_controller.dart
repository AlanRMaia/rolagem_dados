import 'package:get/get.dart';
import 'package:rolagem_dados/models/room.dart';

class RoomModelController extends GetxController {
  static RoomModelController get to => Get.find();

  final Rx<RoomModel> _roomModel = RoomModel().obs;

  RoomModel get room => _roomModel.value;

  set room(RoomModel value) {
    _roomModel.value = value;
  }

  void clear() {
    _roomModel.value = RoomModel();
  }

// final MyRepository repository;
// UserController({@required this.repository}) : assert(repository != null);
//
  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
//
}
