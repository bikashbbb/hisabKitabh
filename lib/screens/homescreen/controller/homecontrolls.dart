import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  static int pageIndex = 1;

  void changePage(int index) {
    pageIndex = index;
    update();
  }
}
