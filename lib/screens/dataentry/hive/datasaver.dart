import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';

// tody i have to finish the remove at home and at the other page remove !
class HiveDatabase {
  String boxKonaam;
  Map? object;
  bool isUpdate;
  bool isDaily;

  HiveDatabase(
    this.isDaily, {
    required this.boxKonaam,
    this.object,
    this.isUpdate = false,
  }) {
    // yeta tira have to close hive
    if (isDaily) {
      acc = dailyacc;
    } else {
      acc = lendAcc;
    }
    accSaverBOx = Hive.box(dailyNuserinfo);
  }

  late String acc;
  late Box accSaverBOx;

  Box? recordSaverBox;

  /// holds all the data of total account
  Map<dynamic, dynamic>? allaccount;

  /// code of the account name
  late int code;

  /// length of the current account where user is adding up the model
  late int totalLength;

  /// index of the object that we current are adding upp.
  int? objectindex;

  Future<bool> saveModel() async {
    // here will check if the box alredy exists or we have to create a new box !

    try {
      await setAcc();
      setData();

      return true;
    } on Exception {
      return false;
    }
  }

// shall i close box after each adding up?? i have to
  Future<void> setAcc() async {
    if (accSaverBOx.containsKey(acc)) {
      if (!getAllaccount.containsKey(aName)) {
        saveAccount();
        updateEntryControlls();
      }
    } else {
      await accSaverBOx.put(acc, allAccountstosjon());
    }
  }

  /// set the data also upate the length of the map.
  void setData() {
    // set the data into the acc., i dont need the
    saveObject();
  }

  Future<Box> setRecordSaver() async {
    return recordSaverBox = await Hive.openBox(boxKonaam);
  }

  /// uses the code + index...
  void saveObject() async {
    //recordSaverBox.length use this as a key and store in object ;
    Box putKey = await setRecordSaver();
    object!["uniqueId"] = putKey.length;
    recordSaverBox!.put(putKey.length + 1, object);
  }

  /// uses the account name as key to set the data..
  Map allAccountstosjon() {
    return {aName: object!["isSell"]};
  }

  /// this gives unique number for the total account

  get getAllaccount {
    allaccount = accSaverBOx.get(acc);
    if (allaccount == null) {
      return {};
    }
    return allaccount;
  }

  void saveAccount() {
    getAllaccount;
    allaccount![aName] = object!["isSell"];
    updateCode();
  }

  void updateEntryControlls() {
    EntryControlls controlls = Get.find<EntryControlls>();
    controlls.allAccounts.add(aName);
  }

  void updateCode() {
    accSaverBOx.put(acc, allaccount);
  }

  dynamic getItems(int key) {
    // iterate all the item !
    Map? value = recordSaverBox!.get(key);
    if (value == null) {
      return null;
    }
    if (value.containsKey('isSment')) {
      return SettleMent.fromJson(value);
    } else {
      return Transaction.fromJson(value);
    }
  }

  Future<void> removeAccount(String aName) async {
    await Hive.deleteBoxFromDisk(aName);
    allaccount!.remove(aName);
    updateCode();
  }

  Future<int> getBoxLen(String aName) async {
    Box b = await Hive.openBox(aName);
    return b.length;
  }

  bool isAccountCreated(bool isDaily) {
    return accSaverBOx.containsKey(isDaily ? dailyacc : lendAcc);
  }

  Future<void> removeRecord(int key) async {
    await recordSaverBox!.delete(key);
  }

  double getTotalAmount() {
    double amnt = 0;
    for (Map item in recordSaverBox!.values) {
      amnt += item["totalAmount"];
    }
    return amnt;
  }
}
