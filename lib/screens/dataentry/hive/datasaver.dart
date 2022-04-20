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
      acc = dailyNuserinfo;
    } else {
      acc = lendbox;
    }
    accSaverBOx = Hive.box(acc);
  }

  late String acc;
  late Box accSaverBOx;

  late Box recordSaverBox;

  /// holds all the data of total account
  late Map<String, dynamic>? allaccount;

  /// code of the account name
  late int code;

  /// length of the current account where user is adding up the model
  late int totalLength;

  /// index of the object that we current are adding upp.
  int? objectindex;

  bool saveModel() {
    // here will check if the box alredy exists or we have to create a new box !

    try {
      // this worked lets check data..
      // lets get its length ...
      setAcc();
      setData();
      recordSaverBox.close();
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
  void setData() async {
    // set the data into the acc., i dont need the
    recordSaverBox = await Hive.openBox(boxKonaam);
    saveObject();
  }

  /// uses the code + index...
  void saveObject() {
    //recordSaverBox.length use this as a key and store in object ;
    int putKey = recordSaverBox.length;
    object!["uniqueId"] = putKey;
    recordSaverBox.put(putKey, object);
  }

  void updateAmount() {}

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

  String getKey(String secKey) {
    return code.toString() + secKey;
  }

  Transaction? getItems(String key) {
    // iterate all the item !
    Box _recordBox = Hive.box(key);
    Map? output = _recordBox.get(key);
    if (output == null) {
      return null;
    }
    return Transaction.fromJson(output);
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

  void removeAccount(String aName) {
    Hive.deleteBoxFromDisk(aName);
    allaccount!.remove(aName);
    updateCode();
  }

  /* bool deleteAcc(String key){

  } */
  // this algo is preety good !
  int getAccLen(String accName) {
    return recordSaverBox.length;
  }
}
