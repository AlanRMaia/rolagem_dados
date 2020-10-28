import 'package:get/get.dart';

class ChatController extends GetxController {
final _isComposing = false.obs; 
// ignore: unnecessary_getters_setters
bool get isComposing => _isComposing.value;
// ignore: unnecessary_getters_setters
set isComposing(bool value) => _isComposing.value = value;

}