import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget helptext(String text) {
  return Container(
    width: 330.w,
    height: 200.h,
    child: Text(
      text,
      style: appbarStyle,
    ),
  );
}
