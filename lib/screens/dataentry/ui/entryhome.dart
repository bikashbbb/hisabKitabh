import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/homescreens.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/iconboard.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/screens/dataentry/controller/entrycontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// user put in daily entries here ,daily cash entry !!
class DailyEntryPage extends StatelessWidget {
  final Box? bwx;
  const DailyEntryPage({Key? key, required this.bwx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: iconGreen,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 700.h,
          decoration: homeDecoration,
          child: GetBuilder<EntryControlls>(
              init: EntryControlls(boxxx: bwx),
              builder: (b) {
                return b.hasDataSaved
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DataScreen(),
                      )
                    : entryFirst();
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
