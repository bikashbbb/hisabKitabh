import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/homescreens.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/iconboard.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/screens/dataentry/controller/homescreenc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// user put in daily entries here ,daily cash entry !!
class DailyEntryPage extends StatelessWidget {
  final String boxname;
  bool isdaily;
  DailyEntryPage(this.isdaily, {Key? key, required this.boxname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: iconGreen,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 700.h,
          decoration: homeDecoration,
          child: GetBuilder<HomeControllerInterface>(
              init: HomeControllerInterface(isdaily),
              builder: (b) {
                return b.doesAccExists() ? const DataScreen() : entryFirst();
              }),
        ));
  }
}

Widget entryFirst() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(right: 40.w),
        child: const IconBoard(
          imagePath: 'assets/images/bookwriting.png',
        ),
      ),
      helptext("goal2".tr),
      SizedBox(
        height: 29.h,
      ),
      dailyButton
    ],
  );
}
