import 'package:get/get.dart';

class NavigatorController extends GetxController {
  int currentIndex = 0;
  setIndex(int index) {
    currentIndex = index;
    update();
  }
}
