import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  Box boxname;
  Transaction object;

  HiveDatabase(this.boxname, this.object);

  /// holds all the data of total account
  late Map allaccount;

  /// code of the account name
  late int code;

  /// length of the current account where user is adding up the model
  late int totalLength;

  /// index of the object that we current are adding upp.
  int? objectindex;

  bool saveModel() {
    try {
      setAcc();
      setData();

      return true;
    } on Exception {
      return false;
    }
  }

// {"code":{"l":length,"online":upto,"uid":"0"}} - key is the unique code we have settt..
// ("accounts":"code", "bik":0) - acc
// {"index+code":model,"00":transaobj} - key name

  void setAcc() {
    if (boxname.containsKey(acc)) {
      //boxname.put(acc, allAccountstosjon(false, giveUniqueNum(boxname)));

      if (getAllaccount.containsKey(accountName.text)) {
        // get its code ...
        getcode;
        getTotalLength;
      } else {
        // set its code and totallength
        setCode;
        setLength;
      }
    } else {
      boxname.put(acc, allAccountstosjon(true, setUniqueNum()));
      setLength;
    }
  }

  /// set the data also upate the length of the map.
  void setData() {
    // key will be code+Totallength
    // if object index is empty then set the first one to 0
    objectindex = getobjectIndex;
    object.uniqueId = objectindex;

    upateObject();
    updateObjIndex();
    upadteMapLen();
  }

  void upateObject() {
    boxname.put(code + objectindex!, object);
  }

  /// update the index of the transaction object
  void updateObjIndex() {
    setObjectIndex(getKey(objectkoIndex), i: objectindex! + 1);
  }

  /// update the length of the particular account
  void upadteMapLen() {
    totalLength += 1;
    updateLength();
  }

  /// uses the account name as key to set the data..
  Map allAccountstosjon(bool isfirst, int uid) {
    if (isfirst) {
      return {accountName.text: uid};
    }
    return {
      // else add the account name and the uniq num in
      acc: {acc}
    };
  }

  /* get giveObjectIndex {
    // "code":{"l":length}
    objectindex = boxname.get(code)["index"] + 1;
    boxname.put(code, value)
  } */

  /// this gives unique number for the total account
  int giveUniqueNum() {
    return boxname.get(lastUniq) + 1;
  }

  int setUniqueNum() {
    boxname.put(lastUniq, 0);
    code = 0;
    return code;
  }

  get getAllaccount {
    allaccount = boxname.get(acc);

    return allaccount;
  }

  get getcode {
    code = getAllaccount[accountName.text];
    return code;
  }

  get getTotalLength {
    // "code":"length"
    totalLength = boxname.get(code);
  }

  get getobjectIndex {
    String keeey = getKey(objectkoIndex);
    if (boxname.containsKey(keeey)) {
      return boxname.get(getKey(objectkoIndex));
    }
    setObjectIndex(keeey);
    return 0;
  }

  void setObjectIndex(String ke, {int i = 0}) {
    boxname.put(ke, i);
  }

  void setCode() {
    getAllaccount;
    code = giveUniqueNum();
    allaccount[accountName.text] = code;
    updateCode;
  }

  void setLength() {
    // getTotalLength;
    totalLength = 0;
    updateLength();
  }

  void updateCode() {
    boxname.put(acc, allaccount);
  }

  void updateLength() {
    boxname.put(code, totalLength);
  }

  void hClose() {
    Hive.close();
  }

  String getKey(String secKey) {
    return code.toString() + secKey;
  }
}
