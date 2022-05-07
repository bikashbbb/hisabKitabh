import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/homescreen/controller/homecontrolls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:get/get.dart";
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

// yo muji, vayepachi ava, firebase attach garne aaja ani tyo info tile ko bug fix garne
// components: three , todays goal, daily khata, Lend khata
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var obj = HomeController.to;
  ValueNotifier activeIndex = ValueNotifier<int>(HomeController.pageIndex - 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /* Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: InkWell(
                        onTap: () {
                          activeIndex.value = 0;
                          obj.changePage(1);
                        },
                        child: navbarItems(Icons.attach_money, 'daily'.tr, 0))), */
                InkWell(
                    onTap: () {
                      activeIndex.value = 1;
                      obj.changePage(2);
                    },
                    child: navbarItems(
                        Icons.drive_file_move_rounded, 'entry'.tr, 1)),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: InkWell(
                      onTap: () {
                        activeIndex.value = 2;
                        obj.changePage(3);
                      },
                      child: navbarItems(Icons.handyman, 'entry2'.tr, 2)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget navbarItems(IconData icon, String subtitle, int iconnum) {
    return ValueListenableBuilder(
        valueListenable: activeIndex,
        builder: (_, value, p) {
          bool isactive = activeIndex.value == iconnum;

          return SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      child: Container(
                    height: isactive ? 50.h : 33.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 1,
                          )
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isactive ? iconGreen : Colors.black)),
                    child: Icon(
                      icon,
                      color: isactive ? iconGreen : Colors.black,
                    ),
                  )),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: isactive ? Colors.black : Colors.black87),
                  )
                ],
              ),
            ),
          );
        });
  }

  void icontapped() {
    // gets to another page and also notifies the
  }
}

class ItemCatNavbar extends StatelessWidget {
  final bool iSsale;
  final double totalAmount;
  final Widget addButton;
  final int secs;

  const ItemCatNavbar(this.iSsale,
      {Key? key,
      required this.totalAmount,
      required this.addButton,
      this.secs = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: entryButton,
      height: 50,
      child: Row(
        children: [
          Icon(
            Icons.monetization_on,
            color: black,
          ),
          AnimatedFlipCounter(
            value: totalAmount,
            duration: Duration(seconds: secs),
            textStyle: appbarStyle,
          ),
          const SizedBox(width: 2),
          salesIcon(iSsale),
          const Expanded(child: SizedBox()),
          addButton,
          const Text("   "),
        ],
      ),
    );
  }
}

Widget salesIcon(bool iSsale, {double size = 35}) {
  return Icon(
    iSsale ? Icons.call_made_outlined : Icons.call_received,
    color: iSsale ? iconGreen : red,
    size: size,
  );
}

class UpperNavigationBar extends StatelessWidget {
  const UpperNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      onItemSelected: (index) {
        print(index);
      },
      selectedIndex: 0,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      iconSize: 10,
      backgroundColor: Colors.lightGreen[200], // <-- This works for fixed
      items: [
        BottomNavyBarItem(
            activeColor: Colors.black,
            title: Text("on".tr, style: _white15),
            icon: const Icon(
              Icons.compass_calibration_outlined,
              color: Colors.white,
            )),
        BottomNavyBarItem(
            activeColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("off".tr, style: _white15),
                Icon(
                  Icons.do_disturb_on_sharp,
                  color: red,
                  size: 10,
                )
              ],
            ),
            icon: const SizedBox()),
      ],
    );
  }

  final TextStyle _white15 = const TextStyle(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);
}
