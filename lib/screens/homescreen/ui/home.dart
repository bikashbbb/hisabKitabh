import 'package:app/palette/commonWidgets/appbar.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/screens/dailygoals/ui/dailyhome.dart';
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
      bottomNavigationBar: SizedBox(height: 80.h, child: const BottomNav()),
      body: Stack(
        children: [
          const CustomAppBar(),
          GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controlls) {
                return Builder(builder: (con) {
                  if (controlls.pageIndex == 1) {
                    return Padding(
                      padding: EdgeInsets.only(top: 55.h),
                      child: const DailyGoalsPage(),
                    );
                  } else if (controlls.pageIndex == 2) {
                    return Padding(
                      padding: EdgeInsets.only(top: 55.h),
                      child: const DailyEntryPage(),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 55.h),
                    //child: const DailyGoalsPage(),
                  );
                });
              })
        ],
      ),
    );
  }
}
