// planning: Create some model,with hive

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
  double? totalQuantity;
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

  Transaction({
    this.accName,
    this.isSell = true,
    this.itemname = "",
    this.totalAmount,
    this.totalQuantity,
    this.uniqueId,
    this.createdDate,
    this.perQuantity = 0.0,
    this.perQuantityPrice = 0.0,
    this.quantityType = "plate",
  });
  /// returns transaction by using the variables.
  static Transaction toModel() {
    return Transaction(

    );
  }
}
