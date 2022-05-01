import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/controller/homescreenc.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  static int pageIndex = 2;

  void changePage(int index) {
    pageIndex = index;
    update();
  }
}
