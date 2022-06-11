// it  will hold the entry homes datas.
// what should i be doing?? opening boxes in the name of each account !
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/dialogs/con.dart';
import 'package:app/palette/dialogs/dialogs.dart';
import 'package:app/screens/dataentry/controller/firebase.dart';
import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/ui/itemcatalog.dart';
import 'package:get/get.dart';

// i should have made a fucking abstract class for this
class EntryControlls extends GetxController {
  String boxName;
  final RxList allAccounts = [].obs;
  RxBool isSelectTap = false.obs;

  bool hasdata = true;
  late HiveDatabase o;

  RxBool isSelectTapHome = false.obs;
  Map selectedItemHOme = {}.obs;

  late DialogControlls c;
  // total
  final bool isDaily;

  EntryControlls(this.isDaily, {required this.boxName, bool auto = false}) {
    if (auto) {
      o = HiveDatabase(isDaily, boxKonaam: boxName);
    }
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
  void onTileTapped(String accName, bool isdaily, bool isSales, double? amount,
      int? totalEntries) {
    Get.to(() => AllTransactions(
          isSales,
          accName: accName,
          isdaily: isdaily,
          isOffline: UpperNavigationBar.iSoffline(),
          amount: amount,
          totalEntries: totalEntries,
        ));
  }

  void onSelectTapHome() {
    isSelectTapHome.value = !isSelectTapHome.value;
  }

  void onUnselectTap() {
    selectedItemHOme.clear();
    onSelectTapHome();
  }

  /// adds up the index with unique id in the map , so we can remove both from the list ..... yes yes
  void onCheckBoxTapped(int i, dynamic uId, double? amount) {
    if (isItSelected(i)) {
      selectedItemHOme.remove(i);
      update();
    } else {
      selectedItemHOme[i] = uId;
      update();
    }
  }

  bool isItSelected(int i) {
    return selectedItemHOme.containsKey(i);
  }

  bool isDeleteOn() {
    return selectedItemHOme.isEmpty;
  }

  /// if home its to delete the fucking account ,
  void onDeleteCLicked() {
    initiAlizeControlls();
    if (UpperNavigationBar.iSoffline()) {
      confirmDialog(_deleteAccount, true);
    } else {
      confirmDialog(_deleteAccOnline, true);
    }
  }

  void _deleteAccOnline(bool ishome) {
    _deleteDialog();
    c.totalRcordCount = selectedItemHOme.length;

    selectedItemHOme.forEach((key, value) async {
      if (await FireHomePage.onDeleteItem(isDaily, value)) {
        c.updateTotalRcrdCount(selectedItemHOme.length);
        c.updateCurrentAccIndex();
        // dialog controller lai update garam yeha bata
      } else {}
    });
    c.updateIsfinish();
  }

  void initiAlizeControlls() {
    c = Get.put(DialogControlls());
  }

  /// deletes the record from the database also removes it from the all entry list with help of the index,..

  /// check the islogin shit also...
  void _deleteAccount(bool ishome) async {
    Get.back();
    _deleteDialog();
    c.updateTotalRcrdCount(await _loopTotalboxLength(selectedItemHOme));
    _loopNdelete();
    c.updateIsfinish();
  }

  void _deleteDialog() {
    Get.dialog(DeleteAccDialog(
      "delacc".tr,
      "1",
      ishome: true,
    ));
  }

  void onSelectTap() {
    isSelectTap.value = !isSelectTap.value;
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

  bool? checkIsSales(String accName) {
    if (o.allaccount == null) {
      o.getAllaccount;
    }
    return o.allaccount![accName];
  }

  void onDisposeBox() {
    if (o.recordSaverBox != null) {
      o.recordSaverBox!.close();
    }
  }

  void updateEntry() {
    getAccData;
    selectedItemHOme.clear();
  }
}
