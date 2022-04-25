// it  will hold the entry homes datas.
// what should i be doing?? opening boxes in the name of each account !
import 'package:app/palette/dialogs/con.dart';
import 'package:app/palette/dialogs/dialogs.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/ui/itemcatalog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// offline sav sakenxa aaja ani lend account pani full setup hunxa!, total amount setup also
class EntryControlls extends GetxController {
  String boxName;
  final RxList allAccounts = [].obs;
  int _intitalI = 14;
  int _cIndex = 0;

  bool hasdata = true;
  late HiveDatabase o;
  RxBool isSelectTap = false.obs;
  RxBool isSelectTapHome = false.obs;

  /// will just hold 15 entries.
  RxList allEntry = [].obs;

  /// map with <index: Uid>
  Map selectedItem = {}.obs;
  Map selectedItemHOme = {}.obs;
  int builderTotal = 0;
  int entryTotal = 0;

  //

  EntryControlls({required this.boxName, bool auto = false}) {
    if (auto) {
      o = HiveDatabase(boxName, isDaily);
    }
  }

  Future<bool> setObjects() async {
    o = HiveDatabase(boxName, isDaily);
    await o.setRecordSaver();
    builderTotal = entryTotal = o.recordSaverBox!.length;
    return true;
  }

  get hasDataSaved {
    return o.isAccountCreated(isDaily);
  }

  get getAccData {
    allAccounts.clear();
    Map output = o.getAllaccount;
    for (String i in output.keys) {
      allAccounts.add(i);
    }
    return allAccounts;
  }

  remove() {
    allAccounts.removeAt(0);
  }

  // when clicked on the tile
  void onTileTapped(String accName, bool isdaily) {
    int code = o.getAllaccount[accName];
    Get.delete<EntryControlls>();
    Get.to(() => AllTransactions(
          accCode: code,
          accName: accName,
          isdaily: isdaily,
        ));
  }

  /// only 15 at first and after the 15 is complete next next .
  void getAllEntry({bool isScrolling = false}) {
    for (_cIndex; _cIndex < builderTotal; _cIndex++) {
      Transaction? out = o.getItems(_cIndex);
      if (out != null) {
        allEntry.add(out);
      } else {
        builderTotal += 1;
        _intitalI += 1;
      }
      if (_cIndex == _intitalI) {
        _cIndex++;
        _intitalI += _intitalI;
        break;
      }
    }
  }

  /// remmoves an item from the list as well as
  void removeItemFromDb(int accCode) {}
// select tapp garesi hamro animated container ko side ma euta checkbox aauxaaaa
  void onSelectTap() {
    isSelectTap.value = !isSelectTap.value;
  }

  void onSelectTapHome() {
    isSelectTapHome.value = !isSelectTapHome.value;
  }

  void onUnselectTap(Map input, bool isHOme) {
    isHOme ? selectedItemHOme.clear() : selectedItem.clear();
    isHOme ? onSelectTapHome() : onSelectTap();
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
    confirmDialog(ishome ? _deleteAccount : _delRecord, ishome);
  }

  DialogControlls c = Get.put(DialogControlls());

  void _delRecord(bool ishome) {
    // update the controller ..
    c.totalRcordCount = selectedItem.length;
    _deleteDialog(ishome);
    _delRecordFromDb();
    c.updateIsfinish();
    entryTotal = entryTotal - selectedItem.length;
    update();
    onUnselectTap(selectedItem, false);
  }

  /// deletes the record from the database also removes it from the all entry list with help of the index,..
  void _delRecordFromDb() {
    int removedLen = 0;
    selectedItem.forEach((index, uid) async {
      await o.removeRecord(uid);
      if (index - 1 - removedLen >= 0) {
        allEntry.removeAt(index - 1 - removedLen);
      } else {
        allEntry.removeAt(index - 1);
      }
      removedLen++;
    });
  }

  /// check the islogin shit also...
  void _deleteAccount(bool ishome) async {
    Get.back();
    _deleteDialog(ishome);
    c.updateTotalRcrdCount(await _loopTotalboxLength(selectedItemHOme));
    _loopNdelete();
    c.updateIsfinish();
  }

  void _deleteDialog(bool ishome) {
    Get.dialog(DeleteAccDialog(
      "delacc".tr,
      ishome ? selectedItemHOme.length.toString() : "1",
      ishome: ishome,
    ));
  }

  Future<int> _loopTotalboxLength(Map inpt) async {
    int len = 0;
    for (String aName in inpt.values) {
      len += await o.getBoxLen(aName);
    }
    return len;
  }

  // double loop hanna parchaa !!! one loop for the account and other for all entries.
  void _loopNdelete() async {
    for (var p in selectedItemHOme.values) {
      await o.removeAccount(p);
      c.updateCurrentAccIndex();
    }
    // ava per account ko lagi tesko length samma loop hanna parcha !
  }

  /* void _removeItemFromList() {
    // with animation of course
  } */
}
