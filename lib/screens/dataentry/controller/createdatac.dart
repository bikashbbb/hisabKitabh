import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/dialogs/dialogs.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/firebase.dart';
import 'package:app/screens/dataentry/controller/itemcatcon.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// planning lets create controller
// have a separate file for controller, homepage ko bug pani fixx it !!
class CreateControlls extends GetxController {
  bool isClicked = false;
  List reqFields = [false.obs, false.obs].obs;

  bool isDaily;
  CreateControlls({this.isDaily = true});

  /// holds items to display but should be in a pagination style my man my man.
  List<Transaction> allinfoItems = [];

  HiveDatabase? datasaver;
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

  void onAccNotClear() {
    for (int i = 1; i < fieldslist.length; i++) {
      fieldslist[i].clear();
    }
  }

  /// when clicked on add item
  void onAdditem(bool isPrevsAcc) async {
    Map<String, dynamic> item = Transaction.toJson(isDaily);
    Transaction transObject = Transaction.fromJson(item);

    if (checkReqFields()) {
      _startLoaded();

      if (await _checkWifiSignal()) {
        if (await FireCreateEntry(isDaily, item, item["accName"]).onAdditem() !=
            true) {
          showIndicatorDialog(true);
        }
        _onEntrysaveSucess(transObject, isPrevsAcc);
      } else {
        // offline !!
        offlineSaver(item, isPrevsAcc);
      }
      _startLoaded();
    }

    // have if else statement hw
  }

  Future<void> offlineSaver(dynamic item, bool isPrevsAcc,
      {bool isSettle = false}) async {
    datasaver = HiveDatabase(isDaily,
        // yeha xa samasya
        object: isSettle ? SettleMent.tojson(item) : item,
        boxKonaam: aName);
    bool result = await datasaver!.saveModel();
    if (result) {
      _onEntrysaveSucess(
          isSettle ? item : Transaction.fromJson(item), isPrevsAcc,
          isSettle: isSettle);
    }
  }

  void _onEntrysaveSucess(dynamic transObject, bool isPrevsAcc,
      {bool isSettle = false}) {
    if (!isSettle) {
      onAccNotClear();
      offlineSucess(transObject);
    }
    if (isPrevsAcc && UpperNavigationBar.iSoffline()) {
      _onAddPreviousAcc(transObject);
    }
  }

  void delHiveAcc() {
    datasaver!.recordSaverBox!.close();
  }

  /// adds the data into the list if the list len <14 else just addups in to len
  void _onAddPreviousAcc(dynamic obj) {
    ItemCatControlls con = Get.find<ItemCatControlls>();
    if (con.builderTotal < 13) {
      con.allEntry.add(obj);
    }
    con.increaseTotalAmnt(obj.totalAmount!);
    con.updateEntryTotal();
  }

  /// animates and adds up the item in the builder .
  void offlineSucess(dynamic o) {
    Duration i = const Duration(milliseconds: 600);
    allinfoItems.add(o);
    listkey.currentState!.insertItem(0, duration: i);
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: i,
      curve: Curves.easeOut,
    );
    update();
  }

  void _startLoaded() {
    isClicked = !isClicked;
    update();
  }

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
