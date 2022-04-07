import 'package:app/palette/commonWidgets/appbar.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/screens/dailygoals/ui/dailyhome.dart';
import 'package:app/screens/dataentry/const.dart';
import 'package:app/screens/dataentry/ui/entryhome.dart';
import 'package:app/screens/homescreen/controller/homecontrolls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HisabKitabHome extends StatelessWidget {
  const HisabKitabHome({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: Container(
          decoration: entryButton, height: 80.h, child: const BottomNav()),
      body: Stack(
        children: [
          const CustomAppBar(),
          GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controlls) {
                return Builder(builder: (con) {
                  if (HomeController.pageIndex == 1) {
                    return Padding(
                      padding: EdgeInsets.only(top: 62.h),
                      child: const DailyGoalsPage(),
                    );
                  } else if (HomeController.pageIndex == 2) {
                    return Padding(
                      padding: EdgeInsets.only(top: 62.h),
                      child: DailyEntryPage(
                        bwx: dailyBox,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 62.h),
                    //child: const DailyGoalsPage(),
                  );
                });
              })
        ],
      ),
    );
  }
}
