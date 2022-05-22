// planning: Create some model,with hive

import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class Transaction extends HiveObject {

  String? accName;
  bool isSell;
  String itemname;
  double? totalAmount;
  double? totalQuantit;
  //date is required
  String quantityType;
  double perQuantity;
  double perQuantityPrice;

  /// a unique id that keeps the transactions in order ascending or descending .
  int? uniqueId;
  DateTime createdDate;
  String? editedDate;
  bool isOnlineStored;

  Transaction(
      {required this.accName,
      required this.isSell,
      required this.itemname,
      required this.totalAmount,
      required this.totalQuantit,
      required this.uniqueId,
      required this.createdDate,
      required this.perQuantity,
      required this.perQuantityPrice,
      required this.quantityType,
      required this.isOnlineStored});

  factory Transaction.fromJson(dynamic i, {bool isSnaps = false}) {
    return Transaction(
        uniqueId: i["uniqueId"],
        isOnlineStored: i["isOnlineStored"],
        accName: i["accName"],
        isSell: i["isSell"],
        itemname: i["itemname"],
        totalAmount: i["totalAmount"],
        totalQuantit: i["totalQuantit"],
        createdDate: isSnaps ? i["createdDate"].toDate() : i["createdDate"],
        perQuantityPrice: i["perQuantityPrice"],
        quantityType: i["quantityType"],
        perQuantity: i["perQuantity"]);
  }

  static Map<String, dynamic> toJson(bool isDaily) {
    bool issales = !RollSwitcherControlls.isSale;
    String addup1 = isDaily ? " (sell)" : " (Given)";
    String addup2 = isDaily ? " (buy)" : " (Received)";

    if (issales) {
      if (!accountName.text.contains(addup1)) {
        aName = accountName.text + addup1;
      } else {
        aName = accountName.text;
      }
    } else {
      if (!accountName.text.contains(addup2)) {
        aName = accountName.text + addup2;
      } else {
        aName = accountName.text;
      }
    }
    bool isEmpty = itemName.text.isEmpty;
    // created date change garna parcha !!! also ad ya bs matra choose garna milchaa!
    return {
      "uniqueId": 0,
      "isOnlineStored": false,
      "accName": aName,
      "isSell": issales,
      "itemname": isEmpty ? " Unnamed Item" : itemName.text,
      "totalAmount": TextFieldController.parseDouble(totalAmnt.text),
      "totalQuantit": TextFieldController.parseDouble(totalQuantity.text),
      "createdDate": nowdate,
      "perQuantityPrice":
          TextFieldController.parseDouble(priceperQuantity.text),
      "quantityType": initialitem,
      "perQuantity": TextFieldController.parseDouble(perQuanity.text)
    };
  }
}

// how will i diffrenciate settlement from transaction ??!
class SettleMent {
  // contains the settlement format

}

class AccountInfos {
  double? totalAmnt;
  bool? isSale;
  int? totalEntry;
  String? accName;

  AccountInfos({this.isSale, this.totalAmnt, this.totalEntry, this.accName});

  static fromJson(QueryDocumentSnapshot i) {
    return AccountInfos(
        totalAmnt: i['totalAmount'],
        isSale: i['isSell'],
        accName: i.id,
        totalEntry: i['total_entry']);
  }
}
