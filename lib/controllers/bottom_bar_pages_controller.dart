import 'package:get/get.dart';

class BottomBarPagesController extends GetxController {
  final _indexTab = 0.obs;

  set indexTab(int value) => _indexTab.value = value;
  int get indexTab => _indexTab.value;
}
