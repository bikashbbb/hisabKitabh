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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          loginButoon('Login'),
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Text(
              'Hisab Kitab',
              style: appbarStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: loginButoon('Join'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, top: 4.h, right: 4.w),
            child: iconRounder(Icons.settings),
          )
        ],
      ),
    );
  }
}
