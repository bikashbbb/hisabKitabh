import 'package:flutter/material.dart';

Widget iconRounder(IconData icon) {
  return Container(
    height: 45,
    width: 45,
    decoration: BoxDecoration(
        shape: BoxShape.circle, border: Border.all(color: Colors.white)),
    child: Icon(icon),
  );
}
