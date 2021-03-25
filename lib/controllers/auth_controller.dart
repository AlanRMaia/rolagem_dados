import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/services/data_base.dart';
import 'package:rolagem_dados/utils/root.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();
  final _isPassWordVisible = false.obs;

  bool get isPassWordVisible => _isPassWordVisible.value;

  set isPassWordVisible(bool value) {
    _isPassWordVisible.value = value;
  }

  FirebaseUser get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
  }

  Future<void> createUser(
      String name, String email, String password, String phone) async {
    try {
      final AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //Get.offAll(Root());//fecha todas as pilhas de páginas e vai para a selecionada
      //Get.back();//fecha a página atual e volta a anterior

      //create a user in firestore
      final UserModel _user = UserModel(
        id: _authResult.user.uid,
        name: name,
        email: email,
        phone: phone,
      );

      if (await Database().createNewUser(_user)) {
        //user created succesfully
        Get.find<UserController>().user = _user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error ao criar a conta',
        e.message as String,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      //find user with uid
      final AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
      Get.offAll(Get.toNamed('/'));
      //set user for usermodel in database
    } catch (e) {
      Get.snackbar(
        'Error ao efetuar o login',
        e.message as String,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().clear();
    } catch (e) {
      Get.snackbar(
        'Error ao tentar deslogar',
        e.message as String,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
