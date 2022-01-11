import 'package:app/palette/styles/colors.dart';
import 'package:flutter/material.dart';

Widget iconRounder(Icon icon, bool isBorderDef) {
  return Container(
    height: 45,
    width: 45,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isBorderDef ? Colors.white : iconGreen)),
    child: icon,
  );
}
