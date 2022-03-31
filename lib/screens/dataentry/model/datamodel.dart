// planning: Create some model,with hive

import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:hive/hive.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveType(typeId: 1)
  String? accName;
  @HiveType(typeId: 2)
  bool isSell;
  @HiveType(typeId: 3)
  String itemname;
  @HiveType(typeId: 4)
  double? totalAmount;
  @HiveType(typeId: 5)
  double? totalQuantit;
  //date is required
  @HiveType(typeId: 6)
  String quantityType;
  @HiveType(typeId: 7)
  double perQuantity;
  @HiveType(typeId: 8)
  double perQuantityPrice;
  @HiveType(typeId: 9)

  /// a unique id that keeps the transactions in order ascending or descending .
  int? uniqueId;
  @HiveType(typeId: 10)
  String? createdDate;
  @HiveType(typeId: 11)
  String? editedDate;
  @HiveType(typeId: 12)
  bool isOnlineStored;

  Transaction(
      {this.accName,
      this.isSell = true,
      this.itemname = "Unown Item",
      this.totalAmount,
      this.totalQuantit,
      this.uniqueId,
      this.createdDate,
      this.perQuantity = 0.0,
      this.perQuantityPrice = 0.0,
      this.quantityType = "plate",
      this.isOnlineStored = false});

  /// returns transaction by using the variables.
  static Transaction toModel() {
    bool issales = !RollSwitcherControlls.isSale;
    bool isEmpty = itemName.text.isEmpty;
    return Transaction(
        accName: issales
            ? accountName.text + " (sell)"
            : accountName.text + " (buy)",
        isSell: issales,
        itemname: isEmpty ? " Unnamed Item" : itemName.text,
        totalAmount: TextFieldController.parseDouble(totalAmnt.text),
        totalQuantit: TextFieldController.parseDouble(totalQuantity.text),
        createdDate: nowdate,
        perQuantityPrice:
            TextFieldController.parseDouble(priceperQuantity.text),
        quantityType: initialitem,
        perQuantity: TextFieldController.parseDouble(perQuanity.text));
  }
}
