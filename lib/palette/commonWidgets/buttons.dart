import 'dart:async';
import 'dart:ffi';

import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget loginButoon(String title, String bName) => Container(
      alignment: Alignment.center,
      height: 40.h,
      width: bName == "L" ? 85.w : 60.w,
      child: Text(
        title,
        style: white15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: bName == "L" ? Colors.white : Colors.red),
        color: Colors.black.withOpacity(0.7),
      ),
    );

Widget dailyEntryButton() {
  return Container(
    width: 350.w,
    height: 60.h,
    decoration: entryButton,
    alignment: Alignment.center,
    child: Text(
      "entryb".tr,
      style: TextStyle(
          color: Colors.red[300], fontSize: 16.sp, fontWeight: FontWeight.bold),
    ),
  );
}

class AddButton extends StatefulWidget {
  String text;
  AddButton(this.text, {Key? key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool isAnimated = false;
  late Timer time;
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    time.cancel();
  }

  void startAnimation() {
    time = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isAnimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60.h,
      width: 60.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: AnimatedDefaultTextStyle(
        onEnd: () {
          setState(() {
            isAnimated = !isAnimated;
          });
        },
        style: TextStyle(
          fontSize: isAnimated ? 50.sp : 40.sp,
        ),
        duration: const Duration(seconds: 1),
        child: Text(
          widget.text,
        ),
      ),
    );
  }
}
