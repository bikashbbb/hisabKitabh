import 'package:app/palette/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle small16 = TextStyle(color: Colors.white, fontSize: 16.sp);
TextStyle appbarStyle = TextStyle(
    color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold);

TextStyle white15 =
    TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: "customfont");

TextStyle helpTextStyle = TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  fontSize: 22.sp,
);

TextStyle inputStyle = TextStyle(color: Colors.black, fontSize: 14.sp);

TextStyle optionalstyles(Color color) {
  return TextStyle(color: color, fontSize: 15.sp, fontWeight: FontWeight.bold);
}

TextStyle optiongreen = optionalstyles(iconGreen);
TextStyle optionred = optionalstyles(red!);
TextStyle optionblack = optionalstyles(black);
