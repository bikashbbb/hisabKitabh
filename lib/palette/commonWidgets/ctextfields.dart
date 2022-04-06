import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget addTransactionField(String label,
    {String type = "p",
    bool isnum = false,
    bool isReq = false,
    required TextEditingController con,
    ontap,
    onchanged,
    int? len}) {
  return TextField(
    maxLength: len,
    onTap: ontap,
    onChanged: onchanged,
    controller: con,
    inputFormatters: isnum
        ? [
            FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
          ]
        : [],
    keyboardType: isnum
        ? const TextInputType.numberWithOptions(decimal: true)
        : TextInputType.text,
    style: inputStyle,
    decoration: InputDecoration(
        counterText: "",
        contentPadding:
            EdgeInsets.only(top: 5.h, bottom: 5.h, left: 5.w, right: 2.w),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: isReq ? Colors.red : iconGreen, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isReq ? Colors.red : Colors.black, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
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
