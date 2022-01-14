import 'package:app/palette/commonWidgets/buttons.dart';
import 'package:app/palette/commonWidgets/ctextfields.dart';
import 'package:app/palette/commonWidgets/helptext.dart';
import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/commonWidgets/rollswitch.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateEntry extends StatelessWidget {
  DateTime initialDate = DateTime.now();
  List itemlist = [
    "KG",
    "G",
    "L",
    "piece",
  ];

  CreateEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
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
          formheader(),
          SizedBox(
            height: 20.h,
          ),
          formbody(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.summarize,
                  color: iconGreen,
                ),
                Text(
                  "summary".tr,
                  style: helpTextStyle,
                ),
              ],
            ),
          ),
          formTail()
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
        height: 90.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 190.w,
                  height: 40.h,
                  child: addTransactionField('acc'.tr),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    "eg1".tr,
                    style: redtext,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RollSwitcher(),
                Padding(
                  padding: EdgeInsets.only(left: 14.0.w),
                  child: Text("acctypee".tr, style: redtext),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

// what will body contain? item name, item price, item quantity , total price
  Widget formbody(BuildContext context) {
    Text optional = Text(
      "option".tr,
      style: redtext,
    );
    Widget divEr = const Divider(
      color: Colors.black45,
    );
    //DateTime initialdate = DateTime.now().year;
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: SizedBox(
        height: 300.h,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 40.h,
                      width: 190.w,
                      child: addTransactionField("item".tr, type: "sold".tr)),
                  SizedBox(
                      height: 40.h,
                      width: 190.w,
                      child: addTransactionField("total".tr + " " + "amnt".tr,
                          isnum: true)),
                ],
              ),
              optional,
              divEr,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 40.h,
                      width: 100.w,
                      child: addTransactionField("per".tr + " " + "quantity".tr,
                          isnum: true)),
                  // quantity type have a drop down button
                  dropDownButton(itemlist),
                  SizedBox(
                      height: 40.h,
                      width: 180.w,
                      child: addTransactionField("price".tr, isnum: true)),
                  SizedBox(
                      height: 40.h,
                      width: 100.w,
                      child: addTransactionField(
                          "total".tr + " " + "quantity".tr,
                          isnum: true)),

                  // quantity if price is inputted !
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [optional, optional, optional, optional],
              ),
              divEr,
              Row(
                children: [
                  dateIcon,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formTail() {
    return Material(
      elevation: 3,
      child: Container(
        height: 280.h,
        color: Colors.white,
      ),
    );
  }

  // Future<Widget> _datePicker(){

  // }
}
