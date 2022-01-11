import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateEntry extends StatelessWidget {
  const CreateEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            color: iconGreen,
          ),
          formheader()
        ],
      ),
    );
  }

  Widget formheader() {
    return Row(
      children: [],
    );
  }
}
