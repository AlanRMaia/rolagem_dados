import 'package:get/get.dart';

class TextComposerController extends GetxController {
  final _isComposing = false.obs;
  set isComposing(bool value) => _isComposing.value = value;
  bool get isComposing => _isComposing.value;
}
