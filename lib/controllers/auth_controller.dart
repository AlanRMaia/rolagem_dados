import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';
import 'package:rolagem_dados/services/data_base.dart';

class AuthController extends GetxController {
  final UserController _userController;

  AuthController(this._userController);

  static AuthController get to => Get.find();
  final Database _database = Get.put(Database());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();
  final _isPassWordVisible = false.obs;
  final _isLoading = false.obs;
  final _isDarkMode = true.obs;
  File _imgFile;
  final RxString _imgUrl = ''.obs;
  final _myRooms = 0.obs;
  final _myFriends = 0.obs;

  final _myRoomsFriend = 0.obs;
  final _myFriendsFriend = 0.obs;

  final picker = ImagePicker();

  File get imgFile => _imgFile;
  set imgFile(File value) => _imgFile = value;

  String get imgUrl => _imgUrl.value;
  set imgUrl(String value) {
    _imgUrl.value = value;
  }

  bool get isPassWordVisible => _isPassWordVisible.value;

  set isPassWordVisible(bool value) {
    _isPassWordVisible.value = value;
  }

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
  }

  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(bool value) {
    _isDarkMode.value = value;
  }

  int get myRooms => _myRooms.value;
  set myRooms(int value) => _myRooms.value = value;

  int get myFriends => _myFriends.value;
  set myFriends(int value) => _myFriends.value = value;

  int get myRoomsFriend => _myRoomsFriend.value;
  set myRoomsFriend(int value) => _myRoomsFriend.value = value;

  int get myFriendsFriend => _myFriendsFriend.value;
  set myFriendsFriend(int value) => _myFriendsFriend.value = value;

  FirebaseUser get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
    super.onInit();
  }

  Future<void> createUser(String name, String email, String password,
      String phone, String imgUrl) async {
    isLoading = true;
    try {
      final AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      //Get.offAll(Root());//fecha todas as pilhas de páginas e vai para a selecionada
      //Get.back();//fecha a página atual e volta a anterior

      //create a user in firestore

      // ignore: parameter_assignments
      imgUrl = await _database.imageUser(imgFile: _imgFile);

      final UserModel _user = UserModel(
        id: _authResult.user.uid,
        about: '',
        name: name,
        email: email,
        phone: phone,
        image: imgUrl ??
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7yd3gzdOtAsNDbQNhSJz2uQ49puvNchNxvQ&usqp=CAU',
      );

      if (await _database.createNewUser(_user)) {
        //user created succesfully
        Get.find<UserController>().user = _user;
        isLoading = false;
        this.imgUrl = '';
        Get.offAll(Get.toNamed('/'));
      }
    } catch (e) {
      Get.snackbar(
        'Error ao criar a conta',
        e.message as String,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading = false;
    }
  }

  Future<void> getUser() async {
    try {
      final uid = _firebaseUser.value.uid;
      Get.find<UserController>().user = await _database.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editUser({
    String uid,
    String name,
    String email,
    String password,
    String phone,
    String about,
  }) async {
    try {
      final UserModel _user = UserModel(
        id: uid,
        name: name,
        email: email,
        phone: phone,
        image: UserController.to.user.image,
        about: about,
      );
      await _database.editUser(_user, imgFile);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeDarkMode({bool darkMode, String uid}) async {
    try {
      await _database.changeDarkMode(darkMode: darkMode, uid: uid);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    isLoading = true;

    try {
      //find user with uid
      final AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
      isLoading = false;
      Get.offAll(Get.toNamed('/'));
      //set user for usermodel in database
    } catch (e) {
      Get.snackbar(
        'Error ao efetuar o login',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading = false;
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
      isLoading = false;
    }
  }

  Future<void> numberOfRooms() async {
    try {
      myRooms = await _database.numberOfRooms();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> numberOfFriends() async {
    try {
      myFriends = await _database.numberOfFriends();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> numberOfRoomsFriend(UserModel user) async {
    try {
      myRoomsFriend = await _database.numberOfRoomsFriend(user);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> numberOfFriendsFriend(UserModel user) async {
    try {
      myFriendsFriend = await _database.numberOfFriendsFriend(user);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> showImage() async {
    final pickerfile = await picker.getImage(source: ImageSource.camera);
    _imgFile = File(pickerfile?.path);
    if (pickerfile != null) {
      imgUrl = pickerfile.path;
    }
  }

  Future<void> showImageGallery() async {
    final pickerfile = await picker.getImage(source: ImageSource.gallery);
    _imgFile = File(pickerfile.path);
    if (pickerfile != null) {
      imgUrl = pickerfile.path;
    }
  }

  void resetImage() {
    _imgUrl.value = '';
  }
}
