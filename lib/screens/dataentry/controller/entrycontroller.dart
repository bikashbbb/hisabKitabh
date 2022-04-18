// it  will hold the entry homes datas.

import 'package:app/palette/dialogs/con.dart';
import 'package:app/palette/dialogs/dialogs.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/ui/itemcatalog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class EntryControlls extends GetxController {
  Box? boxxx;
  List<String> allAccounts = [];
  int _intitalI = 14;
  int cIndex = 0;
  late int _totalLen;

  bool hasdata = true;
  late HiveDatabase o;
  bool isSelectTap = false;
  bool isSelectTapHome = false;

  /// will just hold 15 entries.
  RxList allEntry = [].obs;

  Map selectedItem = {};
  Map selectedItemHOme = {};

  EntryControlls({this.boxxx}) {
    o = HiveDatabase(boxxx!);
  }

  get hasDataSaved {
    Map allAccs = o.getAllaccount;
    if (allAccs.isEmpty) {
      return hasdata = false;
    }

    return hasdata;
  }

  get getAccData {
    Map output = o.getAllaccount;
    for (String i in output.keys) {
      allAccounts.add(i);
    }

    return allAccounts;
  }

  // when clicked on the tile
  void onTileTapped(String accName, bool isdaily) {
    int code = o.getAllaccount[accName];
    Get.to(() => AllTransactions(
          accCode: code,
          accName: accName,
          isdaily: isdaily,
        ));
  }

  /// only 15 at first and after the 15 is complete next next .
  void getAllEntry(int code, {bool isScrolling = false}) {
    // loop hanna parcha yeha
    _totalLen = o.getTotalLength(cod: code);
    for (cIndex; cIndex < _totalLen; cIndex++) {
      Transaction? out = o.getItems(code.toString() + cIndex.toString());
      if (out != null) {
        allEntry.add(out);
      } else {
        _totalLen += 1;
        _intitalI += 1;
      }

      if (cIndex == _intitalI) {
        cIndex++;
        _intitalI += _intitalI;
        break;
      }
    }
    //allEntry.refresh();
  }

  /// remmoves an item from the list as well as
  void removeItemFromDb(int accCode) {}
// select tapp garesi hamro animated container ko side ma euta checkbox aauxaaaa
  void onSelectTap() {
    isSelectTap = !isSelectTap;
    update();
  }

  void onSelectTapHome() {
    isSelectTapHome = !isSelectTapHome;
    update();
  }

  void onUnselectTap(Map input, bool isHome) {
    input.clear();
    onSelectTap();
  }

  /// adds up the index with unique id in the map , so we can remove both from the list ..... yes yes
  void onCheckBoxTapped(int i, dynamic uId, {Map? input}) {
    if (isItSelected(i, input!)) {
      input.remove(i);
      update();
    } else {
      input[i] = uId;
      update();
    }
  }

  bool isItSelected(int i, Map m) {
    return m.containsKey(i);
  }

  bool isDeleteOn(Map input) {
    return input.isEmpty;
  }

  /// if home its to delete the fucking account ,
  void onDeleteCLicked(bool ishome) {
    confirmDialog(deleteAccount, ishome);
    // have a loop here so that i delete all the account and set the dialog controller..

    //
  }

  /// check the islogin shit also...
  void deleteAccount(bool ishome) async {
    Get.back();
    // yo void vako vaye thi
    Get.dialog(DeleteAccDialog(
      "delacc".tr,
      ishome ? selectedItemHOme.length.toString() : "1",
      "20",
    ));
    print("lado");
    //loopNdelete();
  }

  // double loop hanna parchaa !!! one loop for the account and other for all entries.
  void loopNdelete() {
    for (var accc in selectedItemHOme.values) {
      // ava yo loop nasakesamma next account jadaina yes yes
      // ava looping in the
      int accCod = o.getcode(accc);
      DialogControlls c = Get.find<DialogControlls>();
      o.deleteRecord(
          accCod, o.getTotalLength(cod: accCod), c.updateCurrentIndex);
      o.removeAccount(accc);
      o.removeLength(accCod);
      c.updateCurrentAccIndex();
    }
    // ava per account ko lagi tesko length samma loop hanna parcha !
  }
}
