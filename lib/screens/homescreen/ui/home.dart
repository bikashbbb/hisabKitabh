import 'package:app/palette/commonWidgets/appbar.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/iconboard.dart';
import 'package:app/palette/commonWidgets/navigationbar.dart';
import 'package:app/screens/dailygoals/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      //  we will have a custom unique appbar...
      bottomNavigationBar: SizedBox(height: 90.h, child: const BottomNav()),
      body: Stack(
        children: [
          const CustomAppBar(),
          Padding(
            padding: EdgeInsets.only(top: 55.h),
            child: const DailyGoalsPage(),
          ),
          IconBoard(
            imagePath: 'assets/images/noun-target-money-4380518-2.png',
          ),
          Positioned(
            top: 390.h,
            left: 40.h,
            right: 40.h,
            child: helptext(
                'Set Todays Sales Goal here so, that you can track your sales target at the \n                  end of the day.'),
          ),
        ],
      ),
    );
  }
}
