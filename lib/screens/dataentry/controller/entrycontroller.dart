// it  will hold the entry homes datas.

import 'package:app/screens/dataentry/hive/datasaver.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/ui/itemcatalog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// fix that bug
class EntryControlls extends GetxController {
  Box? boxxx;
  List<String> allAccounts = [];

  bool hasdata = true;
  late HiveDatabase o;

  /// will just hold 15 entries.

  List<Transaction> allEntry = [];
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
  void onTileTapped(String accName) {
    int code = o.getAllaccount[accName];
    Get.to(() => AllTransactions(
          accCode: code,
          accName: accName,
        ));
  }

  List<Transaction> getAllEntry(int code) {
    // loop hanna parcha yeha
    return allEntry;
  }
}
