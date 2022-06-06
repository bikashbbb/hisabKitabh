import 'package:app/palette/dialogs/con.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:get/get.dart';

import '../../../palette/commonWidgets/navigationbar.dart';
import '../../../palette/dialogs/dialogs.dart';

class ItemCatControlls extends GetxController {
  late HiveDatabase o;
  bool isDaily;
  String boxName;
  int entryTotal = 0, builderTotal = 0;
  RxDouble accTotalAmount = 0.0.obs;
  RxBool isSelectTap = false.obs;
  int _intitalI = 14;
  int _cIndex = 0;

  /// map with <index: Uid>
  Map selectedItem = {}.obs;

  late DialogControlls c;
//RxSet deletedItems = <dynamic>{}.obs;
  Set deletedItems = {};

  /// will just hold 15 entries.
  RxList allEntry = [].obs;
  ItemCatControlls(this.isDaily, this.boxName);
  double selectedItemAmount = 0.0;

  Future<bool> setObjects() async {
    o = HiveDatabase(
      isDaily,
      boxKonaam: boxName,
    );
    await o.setRecordSaver();
    builderTotal = entryTotal = o.recordSaverBox!.length;
    return true;
  }

  void getTotalAmount() {
    accTotalAmount.value = o.getTotalAmount();
  }

  /// only 15 at first and after the 15 is complete next next .
  void getAllEntry({bool isScrolling = false}) {
    for (_cIndex; _cIndex < builderTotal; _cIndex++) {
      dynamic out = o.getItems(_cIndex);
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

  void onDeleteCLicked() {
    initiAlizeControlls();
    if (UpperNavigationBar.iSoffline()) {
      confirmDialog(_delRecord, false);
    } else {
      confirmDialog(_deleterecOn, false);
    }
  }

  void _delRecord(bool ishome) {
    // update the controller ..
    c.totalRcordCount = selectedItem.length;
    _deleteDialog();
    _delRecordFromDb();
    c.updateIsfinish();
    entryTotal = entryTotal - selectedItem.length;
    _onUnselectTap();
    decreaseTotalAmnt(selectedItemAmount);
    update();
  }

  void _onUnselectTap() {
    selectedItem.clear();
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

  void onUnselectTap() {
    _onUnselectTap();
  }

  bool isItSelected(int i) {
    return selectedItem.containsKey(i);
  }

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

  void _deleteDialog() {
    Get.dialog(DeleteAccDialog(
      "delacc".tr,
      "1",
      ishome: false,
    ));
  }

  // select tapp garesi hamro animated container ko side ma euta checkbox aauxaaaa
  void onSelectTap() {
    isSelectTap.value = !isSelectTap.value;
  }

  void updateEntryTotal() {
    entryTotal++;
    update();
  }

  void _deleterecOn(bool ishome) {}

  void onCheckBoxTapped(int i, dynamic uId) {
    if (isItSelected(i)) {
      selectedItem.remove(i);
      update();
    } else {
      selectedItem[i] = uId;
      update();
    }
  }

  bool isDeleteOn() {
    return selectedItem.isEmpty;
  }

  void initiAlizeControlls() {
    c = Get.put(DialogControlls());
  }
}
