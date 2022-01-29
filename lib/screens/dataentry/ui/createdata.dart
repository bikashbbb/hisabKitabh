import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/ctextfields.dart';
import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/commonWidgets/rollswitch.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateEntry extends StatelessWidget {
  CreateEntry({Key? key}) : super(key: key);
  DateTime initialDate = DateTime.now();
  List<String> itemlist = ["Kg", "G", "L", "Item", "plate"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          // TODO:
        },
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 2.h,
              color: Colors.black,
            ),
            formheader(),
            SizedBox(
              height: 13.h,
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
        width: 385.w,
        height: 70.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 170.w,
                  height: 40.h,
                  child: addTransactionField('acc'.tr),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    "eg1".tr,
                    style: optionblack,
                  ),
                )
              ],
            ),
            GetBuilder<RollSwitcherControlls>(
                init: RollSwitcherControlls(),
                builder: (controlls) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RollSwitcher(),
                      Padding(
                          padding: EdgeInsets.only(left: 31.0.w),
                          child: Text(
                            "acctypee".tr,
                            style: controlls.isSale ? optionred : optiongreen,
                          ))
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

// add per quantity,price per quanity and SI unit in More Details Expansion tile,also bs/ad option in date
  Widget formbody(BuildContext context) {
    var optional = GetBuilder<RollSwitcherControlls>(
        init: RollSwitcherControlls(),
        builder: (controlls) {
          return Text(
            "option".tr,
            style: controlls.isSale ? optionred : optiongreen,
          );
        });
    Widget divEr = Divider(
      height: 2.h,
      color: Colors.black45,
    );
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 220.h, minHeight: 200.h),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GetBuilder<RollSwitcherControlls>(
                      init: RollSwitcherControlls(),
                      builder: (controlls) {
                        return SizedBox(
                            height: 40.h,
                            width: 190.w,
                            child: controlls.isSale
                                ? addTransactionField("item".tr, type: "buy".tr)
                                : addTransactionField("item".tr,
                                    type: "sold".tr));
                      }),
                  SizedBox(
                      height: 40.h,
                      width: 190.w,
                      child: addTransactionField("total".tr + " " + "amnt".tr,
                          isnum: true)),
                ],
              ),
              optional,
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
                child: divEr,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: SizedBox(
                        height: 40.h,
                        width: 110.w,
                        child: addTransactionField(
                            "total".tr + " " + "quantity".tr,
                            isnum: true)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0.w),
                    child: clearBUtton("✘"),
                  ),
                  const Calender(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  optional,
                ],
              ),
              divEr,
              // additional details
              /* CustomTile(
                expansionHeight: 20.h,
                nonExpandedHeight: 20.h,
                //nonExpandedcolor: Colors.red,
                nonExpandedWidth: 388.w,
                title: Material(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "details".tr,
                        style: white15,
                      ),
                    )),
              ) */
            ],
          ),
        ),
      ),
    );
  }

  Widget expandedTile() {
    return Row(
      children: [
        SizedBox(
            height: 40.h,
            width: 100.w,
            child: addTransactionField("per".tr + " " + "quantity".tr,
                isnum: true)),
        DropDownButton(itemlist),
        SizedBox(
            height: 40.h,
            width: 110.w,
            child: addTransactionField("price".tr, isnum: true)),
      ],
    );
  }

  Widget formTail() {
    return Material(
      elevation: 3,
      child: Container(
        height: 350.h,
        color: Colors.white,
      ),
    );
  }
}
