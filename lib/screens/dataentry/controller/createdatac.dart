import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// planning lets create controller
// have a separate file for controller
class CreateControlls extends GetxController {
  List reqFields = [false.obs, false.obs].obs;

  /// clear the textfields
  void onclearFields() {
    for (TextEditingController p in fieldslist) {
      p.clear();
    }
  }

  /// when clicked on add item
  void onAdditem() {
    checkReqFields();
    //checkWifiSignal();
  }

  void checkReqFields() {
    for (int p = 0; p <= 1; p++) {
      if (fieldslist[p].text == "") {
        reqFields[p].value = true;
      } else {
        reqFields[p].value = false;
      }
    }
  }

  /// check if user has network returns true else false
  //bool checkWifiSignal() {}
}

class RollSwitcherControlls extends GetxController {
  bool isSale = false;

  static RollSwitcherControlls get to => Get.find();
  void rollSwitched(bool state) {
    isSale = state;
    update();
  }
}
