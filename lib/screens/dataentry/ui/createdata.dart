import 'package:app/palette/commonWidgets/buttons/buttons.dart';
import 'package:app/palette/commonWidgets/buttons/expandedtile.dart';
import 'package:app/palette/commonWidgets/constants/dropdowncons.dart';
import 'package:app/palette/commonWidgets/ctextfields.dart';
import 'package:app/palette/commonWidgets/icon_rounder.dart';
import 'package:app/palette/commonWidgets/rollswitch.dart';
import 'package:app/palette/styles/colors.dart';
import 'package:app/palette/styles/decorations.dart';
import 'package:app/palette/styles/textstyles.dart';
import 'package:app/screens/dataentry/controller/createdatac.dart';
import 'package:app/screens/dataentry/model/datamodel.dart';
import 'package:app/screens/dataentry/textcontroller/c.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// add Daily entry
// this is same for two screens,just make the app bar name a variable,and identify if its editing option,
class CreateEntry extends StatefulWidget {
  final String appbarTitle;
  final bool isDaily;
  const CreateEntry(this.appbarTitle, {Key? key, this.isDaily = true})
      : super(key: key);

  @override
  State<CreateEntry> createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {
  final DateTime initialDate = DateTime.now();
  var obscontroll = Get.put(CreateControlls());

  @override
  void initState() {
    CreateControlls.isDailyE = widget.isDaily;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GetBuilder<CreateControlls>(
          init: CreateControlls(),
          builder: (context) {
            return InkWell(
              onTap: obscontroll.onAdditem,
              child: Container(
                alignment: Alignment.center,
                decoration: circleblackDec,
                height: 50.h,
                width: 50.w,
                child: Text(
                  "+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      bottomNavigationBar: SizedBox(
        height: 30.h,
        //child:
      ),
      //resizeToAvoidBottomInset: true,
      backgroundColor: secondaryC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        title: Text(
          widget.appbarTitle,
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
                    color: darkBlack,
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
                  child: Obx(() => addTransactionField('acc'.tr,
                      con: fieldslist[0],
                      isReq: obscontroll.reqFields[0].value)),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Obx(
                      () => obscontroll.reqFields[0].value
                          ? Text(
                              "req".tr,
                              style: optionred,
                            )
                          : Text(
                              "eg1".tr,
                              style: optionblack,
                            ),
                    ))
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
                            style: RollSwitcherControlls.isSale
                                ? optionred
                                : optiongreen,
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
            style: RollSwitcherControlls.isSale ? optionred : optiongreen,
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
        constraints: BoxConstraints(minHeight: 170.h),
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
                            child: RollSwitcherControlls.isSale
                                ? addTransactionField("item".tr,
                                    type: "buy".tr, con: fieldslist[2])
                                : addTransactionField("item".tr,
                                    type: "sold".tr, con: fieldslist[2]));
                      }),
                  SizedBox(
                      height: 40.h,
                      width: 190.w,
                      child: Obx(
                        () => addTransactionField(
                          "total".tr + " " + "amnt".tr,
                          con: fieldslist[1],
                          isnum: true,
                          isReq: obscontroll.reqFields[1].value,
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  optional,
                ],
              ),

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
                            isnum: true,
                            con: fieldslist[3],
                            onchanged: TextFieldController.changeAmount)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0.w),
                    child: clearBUtton("✘", CreateControlls().onclearFields),
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
              CustomTile(
                trailingicon: Icons.more_horiz,
                body: Container(
                  child: expandedTile(),
                ),
                expansionHeight: 50.h,
                nonExpandedHeight: 24.h,
                nonExpandedWidth: 388.w,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "details".tr,
                      style: optionblack,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget expandedTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.production_quantity_limits,
          color: red,
        ),
        DropDownButton(itemlist),
        SizedBox(
            height: 40.h,
            width: 100.w,
            child: addTransactionField("per".tr + " " + "quantity".tr,
                onchanged: TextFieldController.changeAmount,
                con: fieldslist[4],
                isnum: true)),
        SizedBox(
            height: 40.h,
            width: 130.w,
            child: addTransactionField("price".tr,
                onchanged: TextFieldController.changeAmount,
                isnum: true,
                con: fieldslist[5],
                ontap: CreateControlls.checkPerQuantity)),
      ],
    );
  }

  Widget formTail() {
    return Material(
      elevation: 3,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 350.h,
          color: Colors.white,
          child: ListView.builder(
              itemCount: obscontroll.totalItem,
              itemBuilder: (con, index) {
                return InfoTile(obscontroll.infoItems[index]);
              })),
    );
  }
/* 
  Widget builderCreator() {
    return GetBuilder<CreateControlls>(
        init: CreateControlls(), builder: (controlls) {});
  } */

  @override
  void dispose() {
    super.dispose();
    Hive.close();
    RollSwitcherControlls.isSale = false;
    CreateControlls().onclearFields();
  }
}
