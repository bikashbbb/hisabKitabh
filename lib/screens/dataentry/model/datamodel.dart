// planning: Create some model,with hive

import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
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
  String? createdDate;
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

  factory Transaction.fromJson(Map i) {
    return Transaction(
        uniqueId: i["uniqueId"],
        isOnlineStored: i["isOnlineStored"],
        accName: i["accName"],
        isSell: i["isSell"],
        itemname: i["itemname"],
        totalAmount: i["totalAmount"],
        totalQuantit: i["totalQuantit"],
        createdDate: i["createdDate"],
        perQuantityPrice: i["perQuantityPrice"],
        quantityType: i["quantityType"],
        perQuantity: i["perQuantity"]);
  }

  static Map<String, dynamic> toJson() {
    bool issales = !RollSwitcherControlls.isSale;
    if (issales) {
      accountName.text += " (sell)";
    } else {
      accountName.text += " (buy)";
    }
    bool isEmpty = itemName.text.isEmpty;
    return {
      "uniqueId": 0,
      "isOnlineStored": false,
      "accName": accountName.text,
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
