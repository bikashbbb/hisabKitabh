import 'package:app/palette/commonWidgets/buttons.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/iconboard.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/screens/dataentry/ui/createdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// user put in daily entries here ,daily cash entry !!
class DailyEntryPage extends StatelessWidget {
  const DailyEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iconGreen,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: homeDecoration,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 40.w),
              child: const IconBoard(
                imagePath: 'assets/images/bookwriting.png',
              ),
            ),
            helptext("goal2".tr),
            SizedBox(
              height: 30.h,
            ),
            TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                ),
                onPressed: () {
                  Get.to(const CreateEntry());
                },
                child: dailyEntryButton())
          ],
        ),
      ),
    );
  }
}
