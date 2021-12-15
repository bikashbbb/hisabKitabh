import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loginButoon(String title) => Container(
      alignment: Alignment.center,
      height: 40.h,
      width: title[0] == "L" ? 85.w : 60.w,
      child: Text(
        title,
        style: white15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: title[0] == "L" ? Colors.white : Colors.red),
        color: Colors.black.withOpacity(0.7),
      ),
    );
