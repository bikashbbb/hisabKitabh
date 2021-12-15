import 'package:app/palette/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// components: three , todays goal, daily khata, Lend khata
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  ValueNotifier activeIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: InkWell(
                      onTap: () {
                        activeIndex.value = 0;
                      },
                      child:
                          navbarItems(Icons.attach_money, 'Daily Goals', 0))),
              InkWell(
                  onTap: () {
                    activeIndex.value = 1;
                  },
                  child: navbarItems(
                      Icons.drive_file_move_rounded, 'Daily entry', 1)),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: InkWell(
                    onTap: () {
                      activeIndex.value = 2;
                    },
                    child: navbarItems(Icons.handyman, 'Lend Entry', 2)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget navbarItems(IconData icon, String subtitle, int iconnum) {
    return ValueListenableBuilder(
        valueListenable: activeIndex,
        builder: (_, value, p) {
          bool isactive = activeIndex.value == iconnum;

          return Column(
            children: [
              Align(
                  child: Container(
                height: isactive ? 50.h : 33.h,
                width: 45.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: isactive ? iconGreen : iconwhite)),
                child: Icon(
                  icon,
                  color: isactive ? iconGreen : iconwhite,
                ),
              )),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: isactive ? textGreen : Colors.white54),
              )
            ],
          );
        });
  }

  void icontapped() {
    // gets to another page and also notifies the
  }
}
