import 'package:flutter/material.dart';

TextEditingController accountName = TextEditingController();
TextEditingController itemName = TextEditingController();
TextEditingController totalAmnt = TextEditingController();
TextEditingController totalQuantity = TextEditingController();
TextEditingController perQuanity = TextEditingController();
TextEditingController priceperQuantity = TextEditingController();

List<TextEditingController> fieldslist = [
  accountName,
  totalAmnt,
  itemName,
  totalQuantity,
  perQuanity,
  priceperQuantity
];
