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
    if (checkReqFields()) {
      HiveDatabase datasaver = HiveDatabase(dailyBox, Transaction.toModel());
      if (await _checkWifiSignal()) {
        // save data online
      } else {
        // save data on hive database

        bool result = datasaver.saveModel();
        if (result) {
          // sucesfull so clear up the item and
          onclearFields();

          // animate and add
        } else {
          // not clear item
        }
      }
    }

    // have if else statement hw
  }

  void offlineSucess() {}

  bool checkReqFields() {
    bool allFieldsOk = true;
    for (int p = 0; p <= 1; p++) {
      if (fieldslist[p].text == "") {
        allFieldsOk = false;
        reqFields[p].value = true;
      } else {
        reqFields[p].value = false;
      }
    }
    return allFieldsOk;
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
    if (text.isEmpty) {
      return 0.0;
    }

    return double.parse(text);
  }
}
