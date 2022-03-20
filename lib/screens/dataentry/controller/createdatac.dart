import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// planning lets create controller
// have a separate file for controller
class CreateControlls extends GetxController {
  static bool isDailyE = true;
  List reqFields = [false.obs, false.obs].obs;

  static void checkPerQuantity() {
    if (perQuanity.text == "") {
      perQuanity.text = "1";
    }
  }

  /// clear the textfields
  void onclearFields() {
    for (TextEditingController p in fieldslist) {
      p.clear();
    }
  }

  /// when clicked on add item
  void onAdditem() async {
    HiveDatabase datasaver = HiveDatabase(dailyBox, Transaction.toModel());

    // have if else statement hw
    checkReqFields();
    if (await _checkWifiSignal()) {
      // save data online
    } else {
      // save data on hive database
      datasaver.saveModel();
    }
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
  Future<bool> _checkWifiSignal() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  /* /// adds data offline and returns true if no error
  bool saveOffline() {
    // have a exception catcher
  }

  /// adds data offline and returns true if no error

  bool saveOnline() {

  } */

}

class RollSwitcherControlls extends GetxController {
  static bool isSale = false;

  static RollSwitcherControlls get to => Get.find();
  void rollSwitched(bool state) {
    isSale = state;
    update();
  }
}

class TextFieldController {
  static double getTotalAmount() {
    return (parseDouble(totalQuantity.text) /
        parseDouble(perQuanity.text) *
        parseDouble(priceperQuantity.text));
  }

  static void changeAmount(String controllText) {
    if (totalQuantity.text.isNotEmpty && priceperQuantity.text.isNotEmpty) {
      //checkOnNegativeVal(controllText);

      totalAmnt.text = getTotalAmount().toString();
    } else {
      totalAmnt.text = "";
    }
  }

  static double parseDouble(String text) {
    return double.parse(text);
  }

  /// checks if a textcontroller holds negative value if true then erases it
  /* static void checkOnNegativeVal(String text) {
    int len = text.length;
    if (len > 0) {
      text = "300000";
      /* if(text){

      } */
    } */
}
