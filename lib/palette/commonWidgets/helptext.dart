import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget helptext(String text) {
  return SizedBox(
    width: 330.w,
    child: Text(
      text,
      style: helpTextStyle,
      textAlign: TextAlign.justify,
    ),
  );
}
