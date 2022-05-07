import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/login/logincontrolls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireHomePage {
  bool isDaily;
  FireHomePage(this.isDaily);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// checks for any online data on the db ... if yes returns true
  Query getAccountQuery() {
    Query output = _firestore
        .collection("aG3zl2xbGIM932F74kVbnRrdRj0222")
        .doc("data")
        .collection(isDaily? daily:lendAcc);
    return output;
//CollectionReference<Map<String, dynamic>>(aG3zl2xbGIM932F74kVbnRrdRj0222/data/daily)

    // return output.startAfterDocument(lastSnaps).snapshots().map((querySnap) => querySnap.docs.map((e) =>));
    // output.startAfterDocument(lastSnaps);
  }
}

//class FireItemCat {}

class FireCreateEntry {
  final bool isDaily;
  Map<String, dynamic> object;
  String accountNam;

  FireCreateEntry(this.isDaily, this.object, this.accountNam);
  final String _fieldKey = "isSell";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> onAdditem() async {
    try {
      final val = _firestore
          .collection(Userdata.getCurrnetUsser())
          .doc("data")
          .collection(isDaily ? daily : lendAcc)
          .doc(accountNam);
      val.set({_fieldKey: object[_fieldKey]}).whenComplete(
          () => val.collection("data").add(object));

      return true;
    } catch (e) {
      return e;
    }
  }

  //void _check
}
