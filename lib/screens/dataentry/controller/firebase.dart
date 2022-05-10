import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/login/logincontrolls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class FireHomePage {
  bool isDaily;
  FireHomePage(this.isDaily);
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// use this to get the other queries
  static late CollectionReference _queryoutput;

  /// checks for any online data on the db ... if yes returns true
  Query getAccountQuery() {
    _queryoutput = _firestore
        .collection("aG3zl2xbGIM932F74kVbnRrdRj0222")
        .doc("data")
        .collection(isDaily ? daily : lendAcc);
    return _queryoutput;
  }
}

class FireItemCat {
  String accountName;
  late CollectionReference _snaps;

  FireItemCat(this.accountName);

  Query getEntryQuery() {
    return FireHomePage._queryoutput.doc(accountName).collection("data");
  }

  Future getEntryTotal() async {
    double counter = 0;
/*    await FireHomePage._queryoutput
        .doc(accountName)
        .collection("data")
        .snapshots()
        .listen((data) =>
            data.docs.forEach((doc) => counter += (doc["totalAmount"])));
            
 */
    FireHomePage._firestore
        .collection("aG3zl2xbGIM932F74kVbnRrdRj0222")
        .doc("data")
        .collection(daily)
        .doc(accountName)
        .collection("data")
        .snapshots()
        .listen((data) =>
            data.docs.forEach((doc) => counter += (doc["totalAmount"])));
    return counter;
  }
}

class FireCreateEntry {
  final bool isDaily;
  Map<String, dynamic> object;
  String accountNam;

  FireCreateEntry(this.isDaily, this.object, this.accountNam);
  final String _fieldKey = "isSell";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> onAdditem() async {
    /*   try { */
    // i have two countters 1) no of doc i.e number of accounts 2) amount of account
    DocumentReference accountRef = _firestore
        .collection(Userdata.getCurrnetUsser())
        .doc("data")
        .collection(isDaily ? daily : lendAcc)
        .doc(accountNam);

    DocumentReference dataRef = accountRef.collection("data").doc();
    // batches update both
    final batch = _firestore.batch();
    FieldValue p = FieldValue.increment(object["totalAmount"]);

    batch.set(
        accountRef,
        {
          "totalAmount": p,
          _fieldKey: object[_fieldKey],
        },
        SetOptions(merge: true));
    batch.set(dataRef, object);
    // field value
    // update account refrence

    await batch.commit();

    return true;
    /* } catch (e) {
      return e;
    } */
  }

  //void _check
}
