import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/login/logincontrolls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireHomePage {
  /// checks for any online data on the db ... if yes returns true
  /* static bool hasOnlineAccData(){

  } */

}

//class FireItemCat {}

class FireCreateEntry {
  final bool isDaily;
  Map<String,dynamic> object;

  FireCreateEntry(this.isDaily,this.object);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String uid = "aG3zl2xbGIM932F74kVbnRrdRj02";

  Future<dynamic> onAdditem() async {
    try {
      await _firestore
          .collection(uid)
          .doc(isDaily ? daily : lendAcc)
          .collection("data")
          .add(object);
      return true;
    } catch (e) {
      return e;
    }
  }

  //void _check
}
