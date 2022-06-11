import 'dart:async';

import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/homescreen/controller/homecontrolls.dart';
import 'package:app/screens/login/logincontrolls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireHomePage {
  bool isDaily;
  FireHomePage(this.isDaily);
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// use this to get the other queries
  static late CollectionReference _queryoutput;

  /// checks for any online data on the db ... if yes returns true
  Query getAccountQuery() {
    _queryoutput = _firestore
        .collection(Userdata.getCurrnetUsser())
        .doc("data")
        .collection(isDaily ? daily : lendAcc);
    return _queryoutput;
  }

  static Future<bool> onDeleteItem(bool isdaily, dynamic docId) async {
    try {
      await _firestore
          .collection(Userdata.getCurrnetUsser())
          .doc("data")
          .collection(isdaily ? daily : lendAcc)
          .doc(docId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class FireItemCat {
  String accountName;
  DocumentSnapshot? _output;

  FireItemCat(this.accountName);

  get amount {
    return _output!["totalAmount"];
  }

  get recordCount {
    return _output!["total_entry"];
  }

  Query getEntryQuery() {
    return FireHomePage._queryoutput
        .doc(accountName)
        .collection("data")
        .orderBy("createdDate");
  }

  Future<bool> deleteRecord(String docid, double amount) async {
    // i must have the amount pani !
    try {
      final batch = FireHomePage._firestore.batch();
      FieldValue totalAmnt = FieldValue.increment(-amount);

      batch.set(
          _getDocref(),
          {"totalAmount": totalAmnt, "total_entry": FieldValue.increment(-1)},
          SetOptions(merge: true));

      batch.delete(_getDocref().collection("data").doc(docid));

      await batch.commit();

      return true;
    } catch (e) {
      return false;
    }
  }

  DocumentReference _getDocref() {
    return FireHomePage._firestore
        .collection(Userdata.getCurrnetUsser())
        .doc("data")
        .collection(HomeController.isDailyPage() ? daily : lendAcc)
        .doc(accountName);
  }

  Future getAmount() async {
    Stream sub1 = _getDocref().snapshots();
    sub1.listen(
      _ondata,
    );

    await sub1.first;
  }

  void _ondata(snapshot) {
    _output = snapshot;
  }
}

class FireCreateEntry {
  final bool isDaily;
  Map<String, dynamic> object;
  String accountNam;

  FireCreateEntry(this.isDaily, this.object, this.accountNam);
  static const String _fieldKey = "isSell";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> onAdditem() async {
    DocumentReference accountRef = _firestore
        .collection(Userdata.getCurrnetUsser())
        .doc("data")
        .collection(isDaily ? daily : lendAcc)
        .doc(accountNam);

    DocumentReference dataRef = accountRef.collection("data").doc();
    // batches update both simultaeneously
    final batch = _firestore.batch();
    FieldValue totalAmnt = FieldValue.increment(object["totalAmount"]);

    batch.set(
        accountRef,
        {
          "totalAmount": totalAmnt,
          _fieldKey: object[_fieldKey],
          "total_entry": FieldValue.increment(1)
        },
        SetOptions(merge: true));
    batch.set(dataRef, object);
    await batch.commit();

    return true;
    /* } catch (e) {
      return e;
    } */
  }

  //void _check
}
