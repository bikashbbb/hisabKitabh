import 'package:get/get.dart';

class RollSwitcherControlls extends GetxController {
  bool isSale = false;

  static RollSwitcherControlls get to => Get.find();
  void rollSwitched(bool state) {
    isSale = state;
    update();
  }
}
