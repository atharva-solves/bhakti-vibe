import 'package:get/get.dart';

class RootController extends GetxController {
  // 0 for Aarti, 1 for Wallpaper
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}