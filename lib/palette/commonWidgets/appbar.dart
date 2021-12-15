import 'package:app/palette/commonWidgets/buttons.dart';
import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// items in my appbar : name of application, settings
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.95.h),
      color: iconGreen,
      height: 210.h,
      child: Row(
        children: [
          SizedBox(
              height: 65.h,
              width: 120.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [loginButoon('Login'), loginButoon('Join')],
              )),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Text(
              'Hisab Kitab',
              style: appbarStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.w, top: 10.h),
            child: iconRounder(Icons.settings),
          )
        ],
      ),
    );
  }
}
