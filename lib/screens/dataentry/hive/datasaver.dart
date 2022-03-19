import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  Box boxname;
  late Map allaccount;
  late int code;
  late int totalLength;

  int? indexNcode;

  HiveDatabase(this.boxname);

  bool saveModel(
    Transaction object,
  ) {
    try {
      setAcc();
      setData();

      return true;
    } on Exception {
      return false;
    }
  }

// {"code":{"l":length,"online":upto}} - key name
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
      boxname.put(acc, allAccountstosjon(true, setUniqueNum(boxname)));
    }
  }

  /// set the data also upate the length of the map.
  void setData() {
    //boxname.put(key, value);
    // key will be code+Totallength
  }

  //set onlineSaver(B) {}

  /// uses the account name as key to set the data..

  Map allAccountstosjon(bool isfirst, int uid) {
    if (isfirst) {
      return {
        acc: {accountName.text: uid}
      };
    }
    return {
      // else add the account name and the uniq num in
      acc: {acc}
    };
  }

  /// update the transaction key in our box ....
  bool updateTdb(Transaction obj) {
    bool issucess = true;
    return issucess;
  }

  void adduIdDb() {}

  /*  bool isUserLoggedIn(){

  } */

  int giveUniqueNum() {
    return boxname.get(lastUniq) + 1;
  }

  int setUniqueNum(Box boxname) {
    boxname.put(lastUniq, 0);
    return 0;
  }

  /*  int findUniqueNum(Box boxname) {
    allaccount: boxname.get(acc);
  }  */

  get getAllaccount {
    allaccount = boxname.get(acc);

    return allaccount;
  }

  get getcode {
    code = getAllaccount[accountName.text];
    return code;
  }

  get getTotalLength {
    // {"code":{"l":length,"online":upto}}

    totalLength = boxname.get(code)["l"];
  }

  void setCode() {
    getAllaccount;
    code = giveUniqueNum();
    allaccount[accountName.text] = code;
    updateCode;
  }

  void setLength() {
    // getTotalLength;
    Map res = {
      "l": 0,
    };
    updateLength(res);
  }

  void updateCode() {
    boxname.put(acc, allaccount);
  }

  void updateLength(Map res) {
    boxname.put(code, res);
  }

  void hClose() {
    Hive.close();
  }
}
