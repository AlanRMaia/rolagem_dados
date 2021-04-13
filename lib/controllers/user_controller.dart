import 'package:get/get.dart';
import 'package:rolagem_dados/models/user.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) {
    _userModel.value = value;
  }

  void clear() {
    _userModel.value = UserModel();
  }

// final MyRepository repository;
// UserController({@required this.repository}) : assert(repository != null);
//
  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
//
}
