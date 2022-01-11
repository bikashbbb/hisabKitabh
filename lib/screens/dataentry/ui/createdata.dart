import 'package:app/palette/commonWidgets/ctextfields.dart';
import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/commonWidgets/rollswitch.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateEntry extends StatelessWidget {
  const CreateEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.done_all,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "add".tr,
          style: appbarStyle,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: iconRounder(
                    Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30.sp,
                    ),
                    false),
              ))
        ],
      ),
      body: Column(
        children: [
          Divider(
            height: 2.h,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 125.w, bottom: 4.h, top: 4.h),
            child: Text(
              "acctypee".tr,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          formheader(),
          SizedBox(
            height: 20.h,
          ),
          formbody()
        ],
      ),
    );
  }

  Widget formheader() {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      child: Container(
        alignment: Alignment(0, -0.8.h),
        width: 380.w,
        height: 80.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 190.w,
              child: addTransactionField(),
            ),
            const RollSwitcher()
          ],
        ),
      ),
    );
  }

  Widget formbody() {
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        height: 300,
      ),
    );
  }
}
