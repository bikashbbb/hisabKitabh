// it  will hold the entry homes datas.
// what should i be doing?? opening boxes in the name of each account !
import 'package:app/palette/dialogs/con.dart';
import 'package:app/palette/dialogs/dialogs.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/ui/itemcatalog.dart';
import 'package:get/get.dart';

// next fix the add account shit, completely ,and the size bug at the tile..
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
  double selectedItemAmount = 0.0;

  /// will just hold 15 entries.
  RxList allEntry = [].obs;

  /// map with <index: Uid>
  Map selectedItem = {}.obs;
  Map selectedItemHOme = {}.obs;
  int builderTotal = 0;
  int entryTotal = 0;

  //RxSet deletedItems = <dynamic>{}.obs;
  Set deletedItems = {};
  late DialogControlls c;
  // total
  RxDouble accTotalAmount = 0.0.obs;
  final bool isDaily;

  EntryControlls(this.isDaily, {required this.boxName, bool auto = false}) {
    if (auto) {
      o = HiveDatabase(isDaily, boxKonaam: boxName);
    }
  }

  Future<bool> setObjects() async {
    o = HiveDatabase(
      isDaily,
      boxKonaam: boxName,
    );
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

  // when clicked on the tile
  void onTileTapped(String accName, bool isdaily) {
    Get.delete<EntryControlls>();
    Get.to(() => AllTransactions(
          checkIsSales(accName),
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
    initiAlizeControlls();
    confirmDialog(ishome ? _deleteAccount : _delRecord, ishome);
  }

  void initiAlizeControlls() {
    c = Get.put(DialogControlls());
  }

  void _delRecord(bool ishome) {
    // update the controller ..
    c.totalRcordCount = selectedItem.length;
    _deleteDialog(ishome);
    _delRecordFromDb();
    c.updateIsfinish();
    entryTotal = entryTotal - selectedItem.length;
    onUnselectTap(selectedItem, false);
    decreaseTotalAmnt(selectedItemAmount);
    update();
  }

  void updateEntryTotal() {
    entryTotal++;
    update();
  }

  /// deletes the record from the database also removes it from the all entry list with help of the index,..
  void _delRecordFromDb() {
    // this has a major bug !! fixx it
    selectedItem.forEach((index, uid) async {
      index--;
      deletedItems.add(index);
      selectedItemAmount += allEntry[index].totalAmount;

      await o.removeRecord(uid);
    });
    _updateDeleteItems();
  }

  void _updateDeleteItems() {
    deletedItems.add(3000000);
    update();
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

  bool checkIsSales(String accName) {
    if (o.allaccount == null) {
      o.getAllaccount;
    }
    return o.allaccount![accName];
  }

  void getTotalAmount() {
    accTotalAmount.value = o.getTotalAmount();
  }

  void decreaseTotalAmnt(double inputAmount) {
    accTotalAmount.value -= inputAmount;
    selectedItemAmount = 0;
  }

  void increaseTotalAmnt(double input) {
    accTotalAmount.value += input;
  }

  bool isItDeleted(int indd) {
    return deletedItems.contains(indd);
  }

  void onDisposeBox() {
    if (o.recordSaverBox != null) {
      o.recordSaverBox!.close();
    }
  }
}
