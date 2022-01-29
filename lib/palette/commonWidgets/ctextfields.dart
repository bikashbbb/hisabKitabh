import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget addTransactionField(String label,
    {String type = "p", bool isnum = false}) {
  return TextField(
    //maxLength: null,
    keyboardType: isnum ? TextInputType.number : TextInputType.text,
    style: inputStyle,
    decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 5.h, bottom: 5.h, left: 5.w, right: 2.w),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: iconGreen, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        label: RichText(
          text: TextSpan(children: [
            TextSpan(text: label, style: const TextStyle(color: Colors.black)),
            TextSpan(
                text: type[0] == "p" ? "" : "  ( $type )",
                style: TextStyle(color: black, fontWeight: FontWeight.bold))
          ]),
        ),
        labelStyle: const TextStyle(color: Colors.black)),
  );
}
