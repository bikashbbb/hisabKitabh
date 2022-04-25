import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:hive/hive.dart';

// tody i have to finish the remove at home and at the other page remove !
class HiveDatabase {
  String boxKonaam;
  Map? object;
  bool isUpdate;
  bool isDaily;

  HiveDatabase(
    this.boxKonaam,
    this.isDaily, {
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
  late Map<dynamic, dynamic>? allaccount;

  /// code of the account name
  late int code;

  /// length of the current account where user is adding up the model
  late int totalLength;

  /// index of the object that we current are adding upp.
  int? objectindex;

  bool saveModel() {
    // here will check if the box alredy exists or we have to create a new box !

    try {
      setAcc();
      setData();

      return true;
    } on Exception {
      return false;
    }
  }

// shall i close box after each adding up?? i have to
  void setAcc() {
    if (accSaverBOx.containsKey(acc)) {
      if (!getAllaccount.containsKey(aName)) {
        saveAccount();
      }
    } else {
      accSaverBOx.put(acc, allAccountstosjon());
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
    recordSaverBox!.put(putKey.length, object);
  }

  /// uses the account name as key to set the data..
  Map allAccountstosjon() {
    return {aName: 0};
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
    allaccount![aName] = 0;
    updateCode();
  }

  void updateCode() {
    accSaverBOx.put(acc, allaccount);
  }

  Transaction? getItems(int key) {
    // iterate all the item !
    Map? value = recordSaverBox!.get(key);
    if (value == null) {
      return null;
    }
    return Transaction.fromJson(value);
  }

  /// askes for len of the fcking acc and loop till it ends !!
  /* bool deleteRecord(int accCode, int len, Function updater) {
    bool isSucess = true;
    try {
      for (int i = 0; i < len; i++) {
        String boxKey = accCode.toString() + i.toString();
        if (boxname.containsKey(boxKey)) {
          updater();
          boxname.delete(boxKey);
        } else {
          len += 1;
        }
      }
      return isSucess;
    } on Exception {
      return isSucess = false;
    }
  } */

  Future<void> removeAccount(String aName) async {
    await Hive.deleteBoxFromDisk(aName);
    allaccount!.remove(aName);
    updateCode();
  }

  Future<int> getBoxLen(String aName)async {
    Box b = await Hive.openBox(aName);
    return b.length;
  }

  bool isAccountCreated(bool isDaily) {
    return accSaverBOx.containsKey(isDaily ? dailyacc : lendAcc);
  }
}
