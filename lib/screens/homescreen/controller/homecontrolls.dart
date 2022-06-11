import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  static int pageIndex = 2;

  void changePage(int index) {
    pageIndex = index;
    UpperNavigationBar.setToZero();
    update();
  }

  static isDailyPage() {
    if (pageIndex == 2) {
      return true;
    }
    return false;
  }
}
