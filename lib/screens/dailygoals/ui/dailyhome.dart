import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/iconboard.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyGoalsPage extends StatelessWidget {
  const DailyGoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var object = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: iconGreen,
        body: Container(
            height: object.height,
            width: object.width,
            child: Stack(
              children: [
                const IconBoard(
                  imagePath: 'assets/images/noun-target-money-4380518-2.png',
                ),
                Positioned(
                  top: 390.h,
                  left: 40.h,
                  right: 40.h,
                  child: helptext('goal'.tr),
                ),
              ],
            ),
            decoration: homeDecoration),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 40.h, right: 20.w),
          child: InkWell(onTap: () {}, child:const AddButton("+")),
        ));
  }
}
